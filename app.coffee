express = require 'express'
http    = require 'http'
fs      = require 'fs'
mongo   = require 'mongoose'
path    = require 'path'
che     = require 'cheerio'
Promise = require('node-promise').Promise
_       = require 'lodash'
zip     = require 'node-native-zip-compression'
md5     = require 'MD5'
mkdirp  = require 'mkdirp'
jade    = require 'jade'
cookies = require 'cookies'
markdown= require('node-markdown').Markdown
pretty  = require('pretty-data').pd

port    = 3001  
app     = express()

folder = 'dist'
# folder = 'dev' 

mkdirp "#{folder}/generated-icons", ->
mkdirp 'uploads', ->

oneDay = 86400000
app.set 'port', process.env.PORT or port
app.use express.compress()
app.use express.favicon __dirname + "/#{folder}/favicon.ico"
app.use express.static  __dirname + "/#{folder}", maxAge: oneDay

app.use express.bodyParser(uploadDir: 'uploads')
app.use express.methodOverride()

mongo.connect if process.env.NODE_ENV then fs.readFileSync("db").toString() else 'mongodb://localhost/binary-cookbook'

RecipeSchema = new mongo.Schema
      header:         String
      description:    String
      author:         String
      authorLink:     String
      ago:            String
      text:           String
      estimatedTime:  String
      image:          String
      versions:       Array

RecipeSchema.virtual('id').get -> @_id.toHexString()
# Ensure virtual fields are serialised.
RecipeSchema.set 'toJSON', virtuals: true
Recipe = mongo.model 'recipe', RecipeSchema

io = require('socket.io').listen(app.listen(process.env.PORT or port), { log: false })


io.sockets.on "connection", (socket) ->

  socket.on "recipes:read", (data, callback) ->

    console.log data

    options = 
        skip: (data.page-1)*data.perPage
        limit: data.perPage
        sort:  ago: 1

    Recipe.find {}, null, options, (err, docs)->
      Recipe.find {}, (err, docs2)->
          for doc, i in docs
            doc.versions = doc.versions.length

          callback null, data =
                          models: docs
                          total: docs2.length

  socket.on "recipe:delete", (data, callback) ->
    Recipe.findById data.id, (err, doc)->
      if err
        callback 500, 'DB error'
        console.error err
      else callback null, 'ok'

      doc.remove (err)->
        if err
          callback 500, 'DB error'
          console.error err
        else callback null, 'ok'

  socket.on "recipe:update", (data, callback) ->
    Recipe.findById data.id, (err, doc)->
      if err
        callback 500, 'DB error'
        console.error err
      else callback null, 'ok'

      data.versions = doc.versions.slice(0)

      data.versions.push doc

      id = data.id; delete data._id
      Recipe.update {'_id':id}, data, {upsert:true}, (err)->
        if err
          callback 500, 'DB error'
          console.error err
        else callback data, 'ok'


  socket.on "recipe:create", (data, callback) ->
      new Recipe(data).save (err, doc)->
        if err
          callback 500, 'DB error'
          console.error err
        else callback null, doc.toJSON()



app.get '/gen', (req,res,next)->
  for i in [1..11]
    new Recipe(
        header:         "ChocoTaco-#{i}"
        description:    "lean mean and full of caffeine-#{i}"
        author:         "Gumball-#{i}"
        authorLink:     "http://legomushroom.com"
        ago:            "#{i} hours ago"
        text:           "#{i} So, Tony, this is the section about Getting Started EndDash is a two-way binding javascript templating framework built on top of semantic HTML. <br> <br> In its current release, EndDash relies on Backbone objects. See the dependency section for further details."
        image:          'taco.png'
        estimatedTime:  "#{i}\'"
        versions:       []
    ).save()

    new Recipe(
        header:         "SweetStump-#{i}"
        description:    "wooden and tasty-#{i}"
        author:         "Gumball-#{i}"
        authorLink:     "http://legomushroom.com"
        ago:            "#{i} hours ago"
        text:           "#{i} So, Tony, this is the section about Getting Started EndDash is a two-way binding javascript templating framework built on top of semantic HTML. <br> <br> In its current release, EndDash relies on Backbone objects. See the dependency section for further details."
        image:          'stump.png'
        estimatedTime:  "#{i}\'"
        versions:       []
    ).save()

    new Recipe(
        header:         "Grass'n'Berries-#{i}"
        description:    "red and green - your potential sin-#{i}"
        author:         "Gumball-#{i}"
        authorLink:     "http://legomushroom.com"
        ago:            "#{i} hours ago"
        text:           "#{i} So, Tony, this is the section about Getting Started EndDash is a two-way binding javascript templating framework built on top of semantic HTML. <br> <br> In its current release, EndDash relies on Backbone objects. See the dependency section for further details."
        image:          'grass.png'
        estimatedTime:  "#{i}\'"
        versions:       []
    ).save()

  res.end 'ok'


