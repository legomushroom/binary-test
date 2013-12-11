define 'views/RecipeView', ['views/ProtoView', 'models/RecipeModel'], (ProtoView, RecipeModel)->
	class RecipeView extends ProtoView
		template: '#recipe-template'
		className: 'recipe-b cf'

		events:
			'click .recipe-preview-e': 	'toggleExpand'
			'click #js-remove': 				'remove'
			'click #js-edit': 					'edit'
			'click #js-cancel': 				'cancel'
			'click #js-save': 		  		'save'
			'keyup': 		  							'keyup'


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

			if (confirm("Are you sure whant to remove \"#{ $.trim(@model.get('header')) }\" item?"))
				@$el.fadeOut 500, =>
						@model.destroy()

			@


		edit:(e)-> @model.toggleAttr('isEditMode'); false

		keyup:(e)->
			@isActive = true
			return false if !@model.get('isEditMode') 
			@$('#js-save').toggleClass 'is-inactive', false
			false

		getFromDom:->
			@domData =
				'text': 				@$('#js-body').html()
				'header': 			@$('#js-header').html()
				'description':	@$('#js-description').html()
				'author':				@$('#js-author').html()
				'ago':					@$('#js-ago').html()
				'estimatedTime':@$('#js-estimated').html()

			@domData

		save:(e)->
			return false if !@isActive

			@model.set 	@getFromDom()
			@model.set 'versions', @model.get('versions')+1

			@model.save(); @cancel()
			false

		cancel:(e)->
			@model.set 'isEditMode', false
			App.$bodyHtml.animate 'scrollTop': @$el.offset().top - 150
			false





	RecipeView