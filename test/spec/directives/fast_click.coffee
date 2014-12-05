'use strict'

describe 'Directive: fastClick', ->

  # load the directive's module
  beforeEach module 'geQuizApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<fast-click></fast-click>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the fastClick directive'
