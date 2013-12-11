define 'views/RecipeView', ['views/ProtoView', 'models/RecipeModel'], (ProtoView, RecipeModel)->
	class RecipeView extends ProtoView
		template: '#recipe-template'
		className: 'recipe-b cf'

		events:
			'click .recipe-preview-e': 	'toggleExpand'
			'click #js-remove': 				'remove'
			'click #js-edit': 					'edit'
			'click #js-cancel': 				'cancel'


		initialize:->
			super
			@model.on 'change', _.bind @render, @
			@

		render:->
			super
			@bindAttributes()
			@

		bindAttributes:->
			@$el.toggleClass 'is-edit', !!@model.get('isEditMode')

		toggleExpand:-> @$el.toggleClass 'is-expanded'

		remove:(e)->
			return if !e
			e.stopPropagation()
			
			if (confirm("Are you sure whant to remove \"#{ @model.get('header') }\" item?"))
				@$el.fadeOut 500, =>
						@model.destroy()

			@


		edit:(e)->
			return if !e
			e.stopPropagation()
			@model.toggleAttr 'isEditMode'

		cancel:(e)->
			return if !e
			e.stopPropagation()
			@model.set 'isEditMode', false
			App.$bodyHtml.animate 'scrollTop': @$el.offset().top - 150



	RecipeView