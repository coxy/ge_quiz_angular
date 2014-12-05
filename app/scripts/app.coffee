'use strict'

angular
  .module('App', [
    'ngRoute',
    'ngAnimate',
    'ngSanitize',
    'angulartics',
    'angulartics.google.analytics'
  ])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'Main'
        controllerAs: 'quiz'
      .otherwise
        redirectTo: '/'
