'use strict'

angular.module('App')
  .directive 'imageSection', ['settings', (settings) ->
    restrict: 'E'
    replace: true
    #transclude: true
    #require: '^ngController'
    scope:
      position: "@"
      question: "="
    templateUrl: 'views/directives/image_section.html'
    link: (scope) ->
      scope.image_url = settings.image_path + scope.question.image
  ]