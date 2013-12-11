// Generated by CoffeeScript 1.6.2
(function() {
  var _this = this,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define('collections/RecipesCollection', ['collections/PaginatedCollection', 'backbone', 'models/RecipeModel'], function(PaginatedCollection, B, RecipeModel) {
    var RecipesCollection, _ref;

    RecipesCollection = (function(_super) {
      __extends(RecipesCollection, _super);

      function RecipesCollection() {
        _ref = RecipesCollection.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      RecipesCollection.prototype.url = 'recipes';

      RecipesCollection.prototype.model = RecipeModel;

      RecipesCollection.prototype.addNew = function() {
        this.add({
          isEditMode: true,
          isNew: true
        }, {
          at: this.length
        });
        return this;
      };

      return RecipesCollection;

    })(B.Collection);
    return RecipesCollection;
  });

}).call(this);
