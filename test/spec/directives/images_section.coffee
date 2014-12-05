'use strict'

describe 'Directive: imagesSection', ->

  # load the directive's module
  beforeEach module 'geQuizApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<images-section></images-section>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the imagesSection directive'
