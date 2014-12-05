'use strict'

angular.module('App')
  .directive 'question', ($animate) ->
    restrict: 'E'
    replace: true
    transclude: true
    scope:
      index: '@'
      question: '='
      showWhen: '='
    templateUrl: 'views/directives/question.html'
    link: (scope, element) ->
      if scope.question
        scope.question.index = scope.index

      scope.$watch 'showWhen', (show, oldShow) ->
        if show and scope.question and scope.question.index == 0
          element.addClass 'active'
        else if show
          $animate.addClass element, 'active', ->
            inputs = element.find("input")
            if inputs.length > 0
              inputs.val("")
              inputs[0].focus() 
        else
          $animate.removeClass element, 'active', angular.noop
