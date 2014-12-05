'use strict'

describe 'Service: audioPlayer', ->

  # load the service's module
  beforeEach module 'geQuizApp'

  # instantiate service
  audioPlayer = {}
  beforeEach inject (_audioPlayer_) ->
    audioPlayer = _audioPlayer_

  it 'should do something', ->
    expect(!!audioPlayer).toBe true
