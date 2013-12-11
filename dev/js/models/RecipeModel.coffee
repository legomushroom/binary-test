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
			'ago': 						'0 added ago'
			'text': 					'text'
			'estimatedTime': 	'5\''
			'versions': 			[]

	RecipeModel