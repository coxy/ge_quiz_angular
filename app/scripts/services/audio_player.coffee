'use strict'

angular.module('App')
  .factory 'AudioPlayer', (settings) ->
    class AudioPlayer
      constructor: (@filename) ->
        @playing = false
        @audio_element = new Audio()
        @audio_element.src = "#{settings.audio_path}#{@filename}"
        @audio_element.load()

      play: ->
       # console.log("playing #{@filename}")
        @audio_element.play()
