define 'models/RecipeModel', ['models/ProtoModel', 'helpers'], (ProtoModel, helpers)->
	class RecipeModel extends ProtoModel
		url: 'recipe'
		defaults:
			'isEditMode': 		false
			'header': 				'Recipe header'
			'description': 		'description'
			'author': 				'Author'
			'authorLink':			'http://legomushroom.com/'
			'image': 					'taco.png'
			'ago': 						'added ago'
			'text': 					'text'
			'estimatedTime': 	'5\''

	RecipeModel