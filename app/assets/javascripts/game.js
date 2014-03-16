var QuizGame = {

  init: function(){
    if($("#quiz").length == 0 ) return;
    QuizGame.setupGame();
    QuizGame.start();
  },

  // resets the variables, sets timer, hide stuff & bind events
  setupGame: function(){

    // set initial variables:
    QuizGame.baseTimer = 10;
    QuizGame.currentQuestion = 1;
    QuizGame.totalQuestions = $('.question').length;

    // bind events
    $('.answer-button').on('click', QuizGame.selectAnswer)

    // hide all questions
    $('.question').hide()


  },

  // starts the game, initializing first round
  start: function(){

    // show first question
    var q =  $('.question').first()
    q.show().addClass('active')

    // store question id
    QuizGame.qid = q.data('question-id');

    // start stage
    QuizGame.startStage()
  },

  startStage: function(){
    // prepare variables
    QuizGame.timer = 10;
    QuizGame.active = true;

    QuizGame.resetProgress();

    // tick every 1s
    QuizGame.tick();
  },

  // ticks game logic every second
  tick: function(){
    if(QuizGame.timer < 0){
      QuizGame.timerFailed();
      return;
    }

    // draw progress bars
    QuizGame.updateProgress();

    // decrease timer by one
    QuizGame.timer -= 1;

    // tick again
    QuizGame.timeout = window.setTimeout(QuizGame.tick, 1000);
  },

  // draws the progress bar
  updateProgress: function(){
    $('.time-counter').html(QuizGame.timer + 's');
    var bar = (QuizGame.timer / QuizGame.baseTimer) * 100
    $('.timer-progress-bar').css({width: bar + '%'})

    if(bar > 33 && bar < 66){
      $('.timer-progress-bar').removeClass('progress-bar-success').addClass('progress-bar-warning')
    } else if(bar < 33) {
      $('.timer-progress-bar').removeClass('progress-bar-warning').addClass('progress-bar-danger')
    }
  },

  resetProgress: function(){
    $('.timer-progress').addClass('active');
    $('.timer-progress-bar')
      .removeClass('progress-bar-warning')
      .removeClass('progress-bar-danger')
      .addClass('progress-bar-success');

    $('.current-question').text(QuizGame.currentQuestion)
    var progress = (QuizGame.currentQuestion / QuizGame.totalQuestions) * 100
    $('.questions-progress-bar').css({width: progress + '%'})

  },

  // logic when user didn't pick answer on time
  timerFailed: function(){

    // dont allow any other events
    QuizGame.active = false;

    // submit null reply
    QuizGame.submitReply(null)
  },

  selectAnswer: function(event){
    event.preventDefault();
    if(QuizGame.active){
      var item = $(this),
          answer_id = item.data('answer-id');

      // pause processing
      QuizGame.active = false;

      // mark clicked item as selected
      item.addClass('list-group-item-info').addClass('active-answer');

      // clean timeout
      window.clearTimeout(QuizGame.timeout);

      // clean animated progress
      $('.timer-progress').removeClass('active');

      // submit reply
      QuizGame.submitReply(answer_id);

    }
  },

  submitReply: function(aid){
    var uri = $("#quiz").data('replies');

    $.ajax({
      url: uri,
      data: {
        question_id: QuizGame.qid,
        answer_id: aid,
        time: QuizGame.timer
      },
      cache: false,
      type: 'POST'
    }).done(function(data){

      var correct_answer,
          active_answer = $('.active-answer');

      // highlight user answer
      active_answer.removeClass('list-group-item-info');

      if(data.success){
        active_answer.addClass('list-group-item-success')
      } else{
        correct_answer = active_answer.siblings('[data-answer-id="' + data.correct_answer +'"]').first();
        correct_answer.addClass('list-group-item-success')
        active_answer.addClass('list-group-item-danger')
      }

      // update score
      $('.game-score').text(data.score);

      // proceed to next stage
      QuizGame.nextStage()
    })
  },

  nextStage: function(){

    // animate next stage in 500ms
    window.setTimeout(function(){
      $('.question.active').fadeOut(function(){
        var old = $('.question.active'),
            next = old.next('.question');

        if(next.length > 0){
          // remove old question and show next
          old.remove();
          next.addClass('active').show();

          QuizGame.qid = next.data('question-id');
          QuizGame.currentQuestion += 1;
          QuizGame.startStage();
        } else{
          QuizGame.finish();
        }
      });
    }, 500);
  },

  finish: function(){
    var results = $("#quiz").data('results');
    window.location.href = results;
  }

}