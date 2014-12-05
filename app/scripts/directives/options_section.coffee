'use strict'

angular.module('App')
  .directive 'optionsSection', ->
    restrict: 'E'
    replace: true
    #transclude: true
    scope:
      position: "@"
      question: "="
    templateUrl: 'views/directives/options_section.html'
    link: (scope) ->
      scope.select = (index) ->
        scope.question.selected_index = index unless scope.question.checked
        #scope.question.answer = scope.question.images[index].
      scope.is_selected = (index) ->
        scope.question.selected_index == index

      scope.is_correct = (option) ->
        scope.question.checked and option.correct

      scope.is_incorrect = (option) ->
        scope.question.checked and !option.correct