class GamesController < ApplicationController

  def new
    @quiz = Quiz.find params[:quiz_id]
  end

  def create
    @quiz = Quiz.find params[:quiz_id]
    @game = Game.new

    @game.quiz = @quiz
    @game.user = current_user

    if @game.valid? && @game.save
      redirect_to quiz_game_path(@quiz, @game)
    else
      flash.now[:error] = "Coś poszło nie tak"
      render action: "new"
    end
  end

  def show
    @quiz = Quiz.find params[:quiz_id]
    @game = @quiz.games.find params[:id]
  end

  def results
    @quiz = Quiz.find params[:quiz_id]
    @game = @quiz.games.find params[:id]
  end

end
