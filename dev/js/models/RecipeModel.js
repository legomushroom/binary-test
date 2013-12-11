// Generated by CoffeeScript 1.6.2
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define('models/RecipeModel', ['models/ProtoModel', 'helpers'], function(ProtoModel, helpers) {
    var RecipeModel, _ref;

    RecipeModel = (function(_super) {
      __extends(RecipeModel, _super);

      function RecipeModel() {
        _ref = RecipeModel.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      RecipeModel.prototype.url = 'recipe';

      RecipeModel.prototype.defaults = {
        'isEditMode': false
      };

      return RecipeModel;

    })(ProtoModel);
    return RecipeModel;
  });

}).call(this);
