define 'models/RecipeModel', ['models/ProtoModel', 'helpers'], (ProtoModel, helpers)->
	class RecipeModel extends ProtoModel
		url: 'recipe'
		defaults:
			'isEditMode': false
			
	RecipeModel