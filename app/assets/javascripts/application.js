//= require jquery
//= require jquery_ujs
// require turbolinks
//= require bootstrap
//= require app


var Quiz = {
  initialTimer: 60,
  timer: 61,
  question: 1,
  state: 'active',

  init: function(){
    if($('#quiz').length == 0) return;

    $('.answer-button').on('click', Quiz.selectAnswer)
    $('.question').hide()

    $('.question').first().addClass('active').show();

    Quiz.resetStage();

  },

  tick: function(){
    if(Quiz.timer == 0){
      Quiz.stageFinish();
      return;
    } else {
      Quiz.timer -= 1;
      $('.time-counter').html(Quiz.timer + 's');
      var bar = (Quiz.timer / Quiz.initialTimer) * 100
      $('.timer-progress-bar').css({width: bar + '%'})
      if(bar > 33 && bar < 66){
        $('.timer-progress-bar').removeClass('progress-bar-success').addClass('progress-bar-warning')
      } else if(bar < 33) {
        $('.timer-progress-bar').removeClass('progress-bar-warning').addClass('progress-bar-danger')
      }

      Quiz.timeout = window.setTimeout(Quiz.tick, 1000);
    }
  },

  selectAnswer: function(event){
    event.preventDefault();

    // do nothing when processing
    if (Quiz.state == 'waiting') return;

    var item = $(this);
    var question_id = item.parents('.question').first().data('question-id');
    var answer_id = item.data('answer-id');


    item.addClass('list-group-item-info').addClass('active-answer');
    Quiz.state = 'waiting';

    Quiz.submitReply(question_id, answer_id);
    Quiz.stageFinish();

  },

  submitReply: function(qid, aid){
    var uri = $("#quiz").data('replies');

    $.ajax({
      url: uri,
      data: {
        question_id: qid,
        answer_id: aid
      },
      cache: false,
      type: 'POST'
    }).done(function(data){
      var active_answer = $('.active-answer')
      var correct_answer;
      active_answer.removeClass('list-group-item-info');

      if(data.success){
        active_answer.addClass('list-group-item-success')
      } else{
        correct_answer = active_answer.siblings('[data-answer-id="' + data.correct_answer +'"]').first();
        correct_answer.addClass('list-group-item-success')
        active_answer.addClass('list-group-item-danger')
      }

      // proceed to next stage
      window.setTimeout(function(){
        $('.question.active').fadeOut(Quiz.nextStage)
      }, 500);
    })

  },

  resetStage: function(){
    Quiz.timer = 61;
    Quiz.state = 'active';
    Quiz.tick();

    $('.timer-progress-bar')
      .removeClass('progress-bar-warning')
      .removeClass('progress-bar-danger')
      .addClass('progress-bar-success');

    $('.timer-progress').addClass('active');

    $('.current-question').html(Quiz.question)
    var total_questions = $(".total-questions").html()
    var questions_progress = (Quiz.question / total_questions) * 100;
    $('.questions-progress-bar').css({width: questions_progress + "%"});

  },

  stageFinish: function(){
    window.clearTimeout(Quiz.timeout);
    $('.timer-progress').removeClass('active');

  },

  nextStage: function(){
    var old = $('.question.active')
    var next = old.next('.question')

    if(next.length > 0){
      old.remove();
      next.addClass('active').show();

      Quiz.question += 1;

      Quiz.resetStage();
    } else{
      Quiz.finish();
    }
  },

  finish: function(){
    var results = $("#quiz").data('results');
    window.location.href = results;
  }
}


$(document).ready(function($){
  Quiz.init();
})