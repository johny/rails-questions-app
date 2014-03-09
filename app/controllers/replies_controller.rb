class RepliesController < ApplicationController

  def create
    @quiz = Quiz.find params[:quiz_id]
    @game = @quiz.games.find params[:game_id]
    @question = @quiz.questions.find params[:question_id]
    @answer = @question.answers.find params[:answer_id]

    if @quiz && @game && @question && @answer

      @reply = Reply.new
      @reply.game = @game
      @reply.question = @question
      @reply.answer = @answer
      @reply.user = current_user

      @reply.is_correct = @answer.is_correct;
      @reply.save

      render json: {success: @reply.is_correct, correct_answer: @question.correct_answer.id }

    else
      render json: false, status: 400
    end


  end


  # private

  #   def question_params
  #     params.require(:question).permit(:id)
  #   end

  #   def answer_params
  #     params.require(:answer).permit(:id)
  #   end

end
