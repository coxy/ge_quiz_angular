'use strict'

describe 'Directive: optionsSection', ->

  # load the directive's module
  beforeEach module 'geQuizApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<options-section></options-section>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the optionsSection directive'
