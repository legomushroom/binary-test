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
    estimatedTime: String,
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
      var options;

      options = {
        sort: {
          ago: 1
        }
      };
      return Recipe.find({}, null, options, function(err, docs) {
        var doc, i, _i, _len;

        for (i = _i = 0, _len = docs.length; _i < _len; i = ++_i) {
          doc = docs[i];
          doc.versions = doc.versions.length;
        }
        return callback(null, docs);
      });
    });
    socket.on("recipe:delete", function(data, callback) {
      return Recipe.findById(data.id, function(err, doc) {
        if (err) {
          callback(500, 'DB error');
          console.error(err);
        } else {
          callback(null, 'ok');
        }
        return doc.remove(function(err) {
          if (err) {
            callback(500, 'DB error');
            return console.error(err);
          } else {
            return callback(null, 'ok');
          }
        });
      });
    });
    socket.on("recipe:update", function(data, callback) {
      return Recipe.findById(data.id, function(err, doc) {
        var id;

        if (err) {
          callback(500, 'DB error');
          console.error(err);
        } else {
          callback(null, 'ok');
        }
        data.versions = doc.versions.slice(0);
        data.versions.push(doc);
        id = data.id;
        delete data._id;
        return Recipe.update({
          '_id': id
        }, data, {
          upsert: true
        }, function(err) {
          if (err) {
            callback(500, 'DB error');
            return console.error(err);
          } else {
            return callback(data, 'ok');
          }
        });
      });
    });
    return socket.on("recipe:create", function(data, callback) {
      return new Recipe(data).save(function(err, doc) {
        if (err) {
          callback(500, 'DB error');
          return console.error(err);
        } else {
          return callback(null, doc.toJSON());
        }
      });
    });
  });

  app.get('/gen', function(req, res, next) {
    var i, _i;

    for (i = _i = 1; _i <= 11; i = ++_i) {
      new Recipe({
        header: "ChocoTaco-" + i,
        description: "lean mean and full of caffeine-" + i,
        author: "Gumball-" + i,
        authorLink: "http://legomushroom.com",
        ago: "" + i + " hours ago",
        text: "" + i + " So, Tony, this is the section about Getting Started EndDash is a two-way binding javascript templating framework built on top of semantic HTML. <br> <br> In its current release, EndDash relies on Backbone objects. See the dependency section for further details.",
        image: 'taco.png',
        estimatedTime: "" + i + "\'",
        versions: []
      }).save();
      new Recipe({
        header: "SweetStump-" + i,
        description: "wooden and tasty-" + i,
        author: "Gumball-" + i,
        authorLink: "http://legomushroom.com",
        ago: "" + i + " hours ago",
        text: "" + i + " So, Tony, this is the section about Getting Started EndDash is a two-way binding javascript templating framework built on top of semantic HTML. <br> <br> In its current release, EndDash relies on Backbone objects. See the dependency section for further details.",
        image: 'stump.png',
        estimatedTime: "" + i + "\'",
        versions: []
      }).save();
      new Recipe({
        header: "Grass'n'Berries-" + i,
        description: "red and green - your potential sin-" + i,
        author: "Gumball-" + i,
        authorLink: "http://legomushroom.com",
        ago: "" + i + " hours ago",
        text: "" + i + " So, Tony, this is the section about Getting Started EndDash is a two-way binding javascript templating framework built on top of semantic HTML. <br> <br> In its current release, EndDash relies on Backbone objects. See the dependency section for further details.",
        image: 'grass.png',
        estimatedTime: "" + i + "\'",
        versions: []
      }).save();
    }
    return res.end('ok');
  });

}).call(this);
