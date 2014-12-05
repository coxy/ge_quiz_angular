'use strict'

angular.module('App')
  .directive 'fastClick', ->
    (scope,element,attrs) ->
      element.bind 'touchstart click', (event) ->
        event.preventDefault()
        event.stopPropagation()
        scope.$apply(attrs['fastClick'])