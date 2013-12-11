define 'collectionViews/ProtoCollectionView', ['marionette', 'views/ProtoView'], (M)->
	class ProtoCollectionView extends M.CompositeView
		
		initialize:(@o={})->
			@o.$el and @setElement @o.$el[0]
			super
			@o.isRender and @render()
			@collection.on 'all', _.bind @render, @
			@

		render:->
			super
			@

		normalizeCollection:(collectionProto)->
			if @model
				modelAttr = for i of modelAttr = @model.toJSON()
					modelAttr[i]
				@collection = new collectionProto modelAttr
				# @model 		= @collection
				modelAttr 	= null

				@collection.parentCollection = @model.collection

		teardown:->
			@isClosed 						= true
			@collection?.isClosed = true

	ProtoCollectionView

