define 'controllers/PagesController', [
	'views/pages/main',
	], (main)->
		class Controller 
			constructor:->
				@main 	= main

		new Controller
