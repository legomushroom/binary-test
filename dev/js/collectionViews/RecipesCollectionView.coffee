define 'collectionViews/RecipesCollectionView', ['collectionViews/ProtoCollectionView', 'views/RecipeView'], (ProtoView, RecipeView)->
	class RecipesCollectionView extends ProtoView
		itemView: RecipeView
		template: '#recipes-collection-template'

		intitialize:->
			@o.isAnimate = true
			super
			@


	RecipesCollectionView

