'use strict'

angular.module('App')
  .directive 'inputSection', ->
    restrict: 'E'
    replace: true
    #transclude: true
    scope:
      position: "@"
      question: "="
    templateUrl: 'views/directives/input_section.html'
    link: (scope, element, attrs, quiz) ->
      input = element.find("input")[0]
      input.focus()
      scope.question.input_element = input