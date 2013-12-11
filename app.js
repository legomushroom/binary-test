// Generated by CoffeeScript 1.6.2
(function() {
  var Promise, Recipe, RecipeSchema, app, che, cookies, express, folder, fs, http, io, jade, markdown, md5, mkdirp, mongo, oneDay, path, port, pretty, zip, _;

  express = require('express');

  http = require('http');

  fs = require('fs');

  mongo = require('mongoose');

  path = require('path');

  che = require('cheerio');

  Promise = require('node-promise').Promise;

  _ = require('lodash');

  zip = require('node-native-zip-compression');

  md5 = require('MD5');

  mkdirp = require('mkdirp');

  jade = require('jade');

  cookies = require('cookies');

  markdown = require('node-markdown').Markdown;

  pretty = require('pretty-data').pd;

  port = 3001;

  app = express();

  folder = 'dev';

  mkdirp("" + folder + "/generated-icons", function() {});

  mkdirp('uploads', function() {});

  oneDay = 86400000;

  app.set('port', process.env.PORT || port);

  app.use(express.compress());

  app.use(express.favicon(__dirname + ("/" + folder + "/favicon.ico")));

  app.use(express["static"](__dirname + ("/" + folder), {
    maxAge: oneDay
  }));

  app.use(express.bodyParser({
    uploadDir: 'uploads'
  }));

  app.use(express.methodOverride());

  mongo.connect(process.env.NODE_ENV ? fs.readFileSync("db").toString() : 'mongodb://localhost/binary-cookbook');

  RecipeSchema = new mongo.Schema({
    header: String,
    description: String,
    author: String,
    authorLink: String,
    ago: String,
    text: String,
    image: String,
    versions: Array
  });

  RecipeSchema.virtual('id').get(function() {
    return this._id.toHexString();
  });

  RecipeSchema.set('toJSON', {
    virtuals: true
  });

  Recipe = mongo.model('recipe', RecipeSchema);

  io = require('socket.io').listen(app.listen(process.env.PORT || port), {
    log: false
  });

  io.sockets.on("connection", function(socket) {
    socket.on("recipes:read", function(data, callback) {
      return Recipe.find({}, null, function(err, docs) {
        return callback(null, docs);
      });
    });
    return socket.on("recipes:delete", function(data, callback) {
      return Recipe.findById(data.id, function(err, doc) {
        console.log(data);
        if (err) {
          callback(500, 'DB error');
          console.error(err);
        } else {
          callback(null, 'ok');
        }
        return doc.remove(function(err) {
          if (err) {
            callback(500, 'fs error');
            return console.error(err);
          } else {
            return callback(null, 'ok');
          }
        });
      });
    });
  });

  app.get('/gen', function(req, res, next) {
    var i, _i;

    for (i = _i = 2; _i <= 12; i = ++_i) {
      new Recipe({
        header: "ChocoTaco" + i,
        description: "lean mean and full of caffeine" + i,
        author: "Gumball" + i,
        authorLink: "http://legomushroom.com",
        ago: "" + i + " hours ago",
        text: "" + i + " So, Tony, this is the section about Getting Started EndDash is a two-way binding javascript templating framework built on top of semantic HTML. <br> <br> In its current release, EndDash relies on Backbone objects. See the dependency section for further details.",
        image: 'asdasd',
        versions: []
      }).save();
    }
    return res.end('ok');
  });

}).call(this);
