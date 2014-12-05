'use strict'

angular.module('App')
  .directive 'textSection', ->
    restrict: 'E'
    replace: true
    scope:
      position: "@"
      question: "="
    templateUrl: 'views/directives/text_section.html'
