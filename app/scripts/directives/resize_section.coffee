angular.module('App')
  .directive 'resizeSection', ($window) ->
    ($scope,$element) ->
      $scope.resize = ->
        ww = $window.innerWidth
        t = (ww - 10 - ww * 0.04 )/3
        if t < 300
          $element.css('height', t + 'px')

      $scope.resize()

      angular.element($window).bind 'resize', ->
        $scope.resize()
        $scope.$apply()