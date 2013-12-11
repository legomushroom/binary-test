define 'collectionViews/RecipesCollectionView', ['collectionViews/ProtoCollectionView', 'views/RecipeView'], (ProtoView, RecipeView)->
	class RecipesCollectionView extends ProtoView
		itemView: RecipeView
		template: '#recipes-collection-template'

		intitialize:->
			@o.isAnimate = true
			super
			@

		appendHtml:(cv, iv, i)-> (if iv.model.get('isNew') then cv.$el.prepend(iv.el) else cv.$el.append iv.el); @


	RecipesCollectionView

