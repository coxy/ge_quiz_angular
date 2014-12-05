'use strict'

angular.module('App')
  .directive 'feedbackSection', ->
    restrict: 'E'
    replace: true
    #transclude: true
    scope:
      position: "@"
      question: "="
    templateUrl: 'views/directives/feedback_section.html'