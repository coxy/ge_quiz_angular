angular.module('App')
  .directive 'resizeSquares', ($window) ->
    ($scope,$element) ->
      $scope.resize = ->
        height = $element[0].offsetHeight #.css('height')
        $element.css('width',height + "px")

      setTimeout($scope.resize,100)
      setTimeout($scope.resize,500)

      angular.element($window).bind 'resize', ->
        $scope.resize()
        $scope.$apply()
