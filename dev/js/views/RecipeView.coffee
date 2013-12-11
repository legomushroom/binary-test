define 'views/RecipeView', ['views/ProtoView', 'models/RecipeModel'], (ProtoView, RecipeModel)->
	class RecipeView extends ProtoView
		model: RecipeModel
		template: '#recipe-template'
		className: 'recipe-b'

		events:
			# 'click': 'toggleExpand'
			'click #js-remove': 'remove'

		initialize:->
			super
			@model.on 'all', _.bind @render, @
			@

		toggleExpand:->
			@$el.toggleClass 'is-expanded'

		remove:(e)->
			return if !e
			e.stopPropagation()

			if (confirm("Are you sure whant to remove \"#{ @model.get('header') }\" item?"))
				@$el.fadeOut 500, =>
						@model.destroy()

			@


	RecipeView