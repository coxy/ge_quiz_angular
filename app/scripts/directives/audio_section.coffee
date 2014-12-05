'use strict'

angular.module('App')
  .directive 'audioSection', ->
    restrict: 'E'
    replace: true
    scope:
      position: "@"
      question: "="
    templateUrl: 'views/directives/audio_section.html'