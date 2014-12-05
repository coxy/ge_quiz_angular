'use strict'

angular.module('App')
  .directive 'dummySection', ->
    template: '<div class="section dummy"></div>'
    restrict: 'E'
    replace: true
