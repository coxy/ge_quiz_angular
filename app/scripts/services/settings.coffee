'use strict'

angular.module('App')
  .constant 'settings',
    data_path:  '/wp-content/plugins/quiz-import/ge_quiz.php'
    image_path: '/quiz-media/images/'
    audio_path:  '/quiz-media/audio/'
    
    feedback_audio:
      correct:   'correct_answer.mp3'
      incorrect: 'incorrect_answer.mp3'
      complete:  'results.mp3'
    results_messages: [
      "You didn't do so well, keep practising!",
      "You're getting there, but you need more practice!",
      "Pretty good, but still room for improvement!",
      "Great!",
      "Perfect score! Well done!"
    ]
    
    errors:
      no_id:   "No quiz id given. Append something like ?id=fruit to the url!"
      general: "We're sorry, but something went wrong.\n\nOur developers have been alerted and we will attempt to resolve the issue as soon as possible. Please try again later."
