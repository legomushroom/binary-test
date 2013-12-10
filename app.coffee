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

# folder = 'dist'
folder = 'dev' 

mkdirp "#{folder}/generated-icons", ->
mkdirp 'uploads', ->

oneDay = 86400000
app.set 'port', process.env.PORT or port
app.use express.compress()
app.use express.favicon __dirname + "/#{folder}/favicon.ico"
app.use express.static  __dirname + "/#{folder}", maxAge: oneDay

app.use express.bodyParser(uploadDir: 'uploads')
app.use express.methodOverride()

process.env.NODE_ENV = true
mongo.connect if process.env.NODE_ENV then fs.readFileSync("db").toString() else 'mongodb://localhost/iconmelon'

SectionSchema = new mongo.Schema
      name:           String
      author:         String
      license:        String
      email:          String
      website:        String
      isMulticolor:   Boolean
      icons:          Array
      moderated:      Boolean
      createDate:     Date

SectionSchema.virtual('id').get -> @_id.toHexString()
# Ensure virtual fields are serialised.
SectionSchema.set 'toJSON', virtuals: true

io = require('socket.io').listen(app.listen(process.env.PORT or port), { log: false })


# io.sockets.on "connection", (socket) ->


#   socket.on "sections:read", (data, callback) ->
#       Section.find {moderated: true}, null, options, (err, docs)->
#           callback null, data =
#                           models: docs


#   socket.on "section:create", (data, callback) ->
#       data.moderated = false
#       data.createDate = new Date
#       new Section(data).save (err)->
#         if err
#           callback 500, 'DB error'
#           console.error err
#         else callback null, 'ok'

#   socket.on "section:update", (data, callback) ->
#     Secret.find {}, (err, docs)->
#       if docs[0].hash isnt socket.getCookie 'secret' then callback(405, 'no, sorry'); return

#       id = data.id; delete data._id
#       Section.update {'_id':id}, data, {upsert:true}, (err)->
#         main.generateMainPageSvg().then =>
#           if err
#             callback 500, 'DB error'
#             console.error err
#           else callback null, 'ok'

#   socket.on "section:delete", (data, callback) ->
#     Secret.find {}, (err, docs)->
#       Section.findById data.id, (err, doc)->
#         if err
#           callback 500, 'DB error'
#           console.error err
#         else callback null, 'ok'
#         doc.remove (err)->
#           if err
#             callback 500, 'fs error'
#             console.error err
#           else callback null, 'ok'

# app.post '/download-icons', (req,res,next)->
#   main.generateProductionIcons(req.body).then (fileName)=>
#     res.send fileName

