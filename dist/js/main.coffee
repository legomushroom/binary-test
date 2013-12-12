require.config
	paths:
		jquery: 		'lib/jquery-2.0.1'
		backbone: 		'lib/backbone'
		underscore: 	'lib/lodash.underscore'
		marionette:		'lib/backbone.marionette'
		babysitter:		'lib/backbone.babysitter'
		wreq:					'lib/backbone.wreqr'
		socketio:			'lib/socket.io'
		'backbone.iosync':	'backbone.iosync'
		'backbone.iobind':	'backbone.iobind'
		fileupload: 	'lib/jquery.fileupload'
		'jquery.ui.widget':'lib/jquery.ui.widget'
		'backbone.stickit': 		'backbone.stickit'
		md5: 				'lib/md5'
		hammer: 		'lib/hammer'
		tween: 			'lib/tween.min'

	shim:
		'backbone.stickit':
			deps: 	['backbone']

		backbone:
			exports: 'Backbone'
			deps: 	['jquery','underscore']

		'backbone.iosync':
			exports: 'Backbone'
			deps: ['backbone', 'socketio']

		'backbone.iobind':
			exports: 'Backbone'
			deps: ['backbone.iosync']

		marionette: 
			exports: 'Backbone.Marionette'
			deps: 	['backbone.stickit']

define 'main', ['marionette', 'router', 'socketio', 'helpers', 'backbone.iobind', 'backbone.stickit' ], (M, Router, io, helpers)->
	
	class Application
		constructor:->
			App = new M.Application()
			App.name = 'binary cookbook'
			window.App = App
			App.addRegions
				main: 	'#main'

			@$mainHeader  = $('#js-main-header')
			@$loadingLine = $('#js-loadin-line')
			
			App.$loadingLine 	= @$loadingLine
			App.$mainHeader 	= @$mainHeader
			App.$bodyHtml 		= $('body, html')

			App.helpers 		= helpers
			App.loadedHashes 	= []

			App.iconsSelected 	= []
			App.filtersSelected = []

			App.isDevMode = window.location.href.match 'localhost'

			socketAdress =  if App.isDevMode then 'http://localhost' else 'http://binary-cookbook.jit.su/' 
			window.socket = io.connect socketAdress

			App.$window = $(window)
			@$mainHeader 	= $('#js-main-header')
			App.$blinded 	= $('#js-blinded')
			# App.$toTops 	= $('.js-to-top')

			$('#js-add-recipe').on 'click', ->
				App.recipesCollection.addNew()


			App.router = new Router
			Backbone.history.start()
			App.start()
			App.helpers.listenLinks()

			@listenEvents()


		listenEvents:->
			# App.$window.on 'scroll', _.throttle( =>
			# 	if App.$window.scrollTop() < App.$window.outerHeight()
			# 		if !@istoTop then return
			# 		App.$toTops.removeClass('animated fadeInUp').addClass('animated fadeOutDown'); 
			# 		@istoTop = false
			# 	else 
			# 		if @istoTop then return
			# 		App.$toTops.removeClass('animated fadeOutDown').addClass('animated fadeInUp'); 
			# 		@istoTop = true
			# , 2000)

			# App.$toTops.on 'click', => App.$bodyHtml.animate 'scrollTop': 300

	new Application
