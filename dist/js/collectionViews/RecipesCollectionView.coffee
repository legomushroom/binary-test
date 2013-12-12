define 'collectionViews/RecipesCollectionView', ['collectionViews/ProtoCollectionView', 'views/RecipeView'], (ProtoView, RecipeView)->
	class RecipesCollectionView extends ProtoView
		itemView: RecipeView
		template: '#recipes-collection-template'

		initialize:(@o={})->
			@o.isAnimate = true
			super
			@listenToScroll()
			@collection.on 'afterFetch', => @lock = false
			@

		appendHtml:(cv, iv, i)-> (if iv.model.get('isNew') then cv.$el.prepend(iv.el) else cv.$el.append iv.el); @

		listenToScroll:->
			console.log 'listen'
			App.$window.on 'scroll', =>
				if App.$window.scrollTop() + App.$window.outerHeight() >= @$el.position().top + @$el.height()
					!@lock and @collection.nextPage()
					@lock = true



	RecipesCollectionView

