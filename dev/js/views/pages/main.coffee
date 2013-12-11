define 'views/pages/main', ['views/pages/PageView', 'collectionViews/RecipesCollectionView', 'collections/RecipesCollection'],(PageView, RecipesCollectionView, RecipesCollection)->

	class Main extends PageView
		template: '#main-template'
		className: "cf main-p"

		render:->
			super
			@renderRecipesList()
			@

		renderRecipesList:->
			@recipes = new RecipesCollection
			@recipes.fetch().then =>
				@recipesView = new RecipesCollectionView
										collection: @recipes
										isRender: true
										$el: @$('#js-recipes-place')

			App.recipesCollection = @recipes


	Main















