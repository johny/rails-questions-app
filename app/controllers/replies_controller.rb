class RepliesController < ApplicationController

  def create

    @quiz = Quiz.find params[:quiz_id]
    @game = @quiz.games.find params[:game_id]
    @question = @quiz.questions.find params[:question_id]
    @answer = @question.answers.find params[:answer_id]

    if @quiz && @game && @question && @answer

      # create reply object
      @reply = Reply.create({
        game_id: @game.id,
        question_id: @question.id,
        answer_id: @answer.id,
        user_id: current_user.id,
        is_correct: @answer.is_correct
      })

      # update score
      @game.count_reply!(@reply)

      render json: {success: @reply.is_correct, correct_answer: @question.correct_answer.id, score: @game.score}

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
