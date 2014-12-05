'use strict'

angular.module('App')
  .controller 'Main', ['$scope','$http','$log','$location','$analytics','$route','AudioPlayer','settings',
    class Main
      constructor: (@_scope, @_http, @_log, @_location, @_analytics, @_route, AudioPlayer, settings) ->
        
        @id = @_location.search().id || false
        @level = @_location.search().level || "default"
        @embedded = @_location.search().embedded || false

        return @handle_error(settings.errors.no_id) if !@id

        @current_index   = -1
        @questions       = []
        @feedback_audio  = []
        @loaded          = false
        @results_messages = settings.results_messages

        for n,audio of settings.feedback_audio
          @feedback_audio[n] = new AudioPlayer(audio)

        @_http.post(settings.data_path,'type': @id).success (data) =>
          @is_guest  = data.guest
          @questions = data.questions
          if @questions.length == 0
            @handle_error settings.errors.general

          for question in @questions
            if @is_audio_question(question)
              question.audio = new AudioPlayer(question.audio)
              question.checked = false

          @next()
          
          if @is_guest
            @log_event('start_quiz_locked')
          else
            @log_event('start_quiz')

          @loaded = true
       
        .error (data, status, headers, config) =>
          @handle_error settings.errors.general
        
      
        @_scope.$on 'quiz:keyup', (event, keyEvent) =>
          @handle_key_event(keyEvent)

      log_event: (quiz_event) ->
        @_analytics.eventTrack(quiz_event, { category: 'quiz', label: @id, value: 1 });

      handle_error: (msg) ->
        alert(msg)

      close: ->
        if window.parent.hasOwnProperty("GE")
          @log_event('close_quiz')
          window.parent.GE.closeQuiz()

      handle_key_event: (event) ->
        return if @is_guest
        code = if window.event then event.keyCode else event.which
        if code == 13 and !@is_complete()
          if !@current_question.hasOwnProperty("correct")
            @check()
            if @current_question.hasOwnProperty("input_element") and @current_question.checked
              @current_question.input_element.blur()
          else
            @next()

         else if !@current_question.checked
            switch code
              when 49, 97 then @current_question.selected_index = 0
              when 50, 98 then @current_question.selected_index = 1
              when 51, 99 then @current_question.selected_index = 2

      normalized_answer: ->
        @current_question.answer.replace(/^\s+|\s+$/g,"")
        .replace(/\.$/,"").toLowerCase()

      is_audio_question: (question) ->
        question.type in [1,2,3]

      current_question: ->
        @questions[@current_index]

      prompt_for_input: (msg) ->
        false

      check: ->
        correct = false

        # typed answers
        if @current_question.type in [1,4,7]
          if !@current_question.hasOwnProperty("answer") || @normalized_answer().length == 0
            @current_question.input_element.focus()
            return @prompt_for_input("Please enter an answer")
          correct = (@normalized_answer() in @current_question.correct_answers)

        # select answers
        else if @current_question.type in [2,5,8]
          if !@current_question.hasOwnProperty("selected_index")
            return @prompt_for_input("Please select an option")
          correct = @current_question.options[@current_question.selected_index].correct

        # image select answers
        else if @current_question.type in [3,6]
          if !@current_question.hasOwnProperty("selected_index")
            return @prompt_for_input("Please select an image")
          correct = @current_question.images[@current_question.selected_index].correct

        @current_question.correct = correct
        @current_question.checked = true

        if correct
          @feedback_audio.correct.play()
        else
          @feedback_audio.incorrect.play()
        
        @log_event('check_question',@current_index)
        @current_question.show_feedback = ((!correct and !@current_question.is_missing_word) or @current_question.type == 3)
      
      show_close_button: ->
        !@embedded

      show_next_button: ->
        !@is_complete() and @current_question.checked

      show_check_button: ->
        !@is_complete() and !@current_question.checked

      show_restart_button: ->
        @is_complete()

      next: ->
        @current_index++
        return if @is_guest
        return @feedback_audio.complete.play() if @is_complete()
        @current_question = @questions[@current_index]
        if @is_audio_question(@current_question)
          @current_question.audio.play()
        @log_event('next_question',@current_index)
      
      restart: ->
        @log_event('restart_quiz')
        @_route.reload()

      is_complete: ->
        @current_index > 0 && @current_index == @questions.length

      final_score: ->
        number_correct = 0
        for question in @questions
          number_correct++ if question.correct
        @log_event("final_score_#{number_correct}") if @is_complete()
        (number_correct / @questions.length)* 100

      results_message: ->
        index = Math.floor(@final_score() / 25)
        index = 4 if index == 5
        @results_messages[index]
    ]
