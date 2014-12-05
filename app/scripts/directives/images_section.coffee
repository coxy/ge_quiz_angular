'use strict'

angular.module('App')
  .directive 'imagesSection', ['settings', (settings) ->
    restrict: 'E'
    replace: true
    #transclude: true
    #require: '^ngController'
    scope:
      position: "@"
      question: "="
    templateUrl: 'views/directives/images_section.html'
    link: (scope) ->

      for image in scope.question.images
        image.image_url = settings.image_path + image.image

      scope.select = (index) ->
        scope.question.selected_index = index unless scope.question.checked
        #scope.question.answer = scope.question.images[index].
      scope.is_selected = (index) ->
        scope.question.selected_index == index

      scope.is_correct = (image) ->
        scope.question.checked and image.correct

      scope.is_incorrect = (image) ->
        scope.question.checked and !image.correct
  ]
      #scope.image_basepath = settings.image_basepath