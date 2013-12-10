// Generated by CoffeeScript 1.6.2
(function() {
  var Promise, SectionSchema, app, che, cookies, express, folder, fs, http, io, jade, markdown, md5, mkdirp, mongo, oneDay, path, port, pretty, zip, _;

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

  mongo.connect(process.env.NODE_ENV ? fs.readFileSync("db").toString() : 'mongodb://localhost/iconmelon');

  SectionSchema = new mongo.Schema({
    name: String,
    author: String,
    license: String,
    email: String,
    website: String,
    isMulticolor: Boolean,
    icons: Array,
    moderated: Boolean,
    createDate: Date
  });

  SectionSchema.virtual('id').get(function() {
    return this._id.toHexString();
  });

  SectionSchema.set('toJSON', {
    virtuals: true
  });

  io = require('socket.io').listen(app.listen(process.env.PORT || port), {
    log: false
  });

}).call(this);
