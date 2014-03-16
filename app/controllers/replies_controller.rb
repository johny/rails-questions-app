class RepliesController < ApplicationController

  def create

    @quiz = Quiz.find params[:quiz_id]
    @game = @quiz.games.find params[:game_id]
    @question = @quiz.questions.find params[:question_id]

    time = params[:time].to_i
    if time < 0 || time > 10
      time = 0
    end

    if params[:answer_id].blank?
      ## means user replied with no answer
      @answer_id = nil
      @correct = false
    else
      @answer = @question.answers.find(params[:answer_id])
      @answer_id = @answer.id
      @correct = @answer.is_correct
    end

    if @quiz && @game && @question

      # create reply object
      @reply = Reply.create({
        game_id: @game.id,
        question_id: @question.id,
        answer_id: @answer_id,
        user_id: current_user.id,
        is_correct: @correct,
        time: time
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
