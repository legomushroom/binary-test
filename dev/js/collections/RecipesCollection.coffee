define 'collections/RecipesCollection', ['collections/PaginatedCollection', 'backbone', 'models/RecipeModel'], (PaginatedCollection, B, RecipeModel)=>
	class RecipesCollection extends PaginatedCollection
		url: 'recipes'
		model: RecipeModel

		addNew:-> @add({ isEditMode: true, isNew: true }, { at: @length }); @

	RecipesCollection