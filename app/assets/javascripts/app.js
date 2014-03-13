var QuizApp = {
  init: function(){
    QuizApp.navigationActiveStates();
  },

  navigationActiveStates: function(){
    $('.nav .active').removeClass('active');
    $('.nav a').each(function(index, item){
      var href = $(item).attr('href')
      if(window.location.pathname == href){
        $(item).parent().addClass('active');
      }
    });
  }
}

$(document).ready(function(){
  QuizApp.init();
});

//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require fastclick/fastclick.js
//= require chart/Chart.js
