define 'collections/RecipesCollection', ['collections/PaginatedCollection', 'backbone', 'models/RecipeModel'], (PaginatedCollection, B, RecipeModel)=>
	class RecipesCollection extends B.Collection
		url: 'recipes'
		model: RecipeModel
	RecipesCollection