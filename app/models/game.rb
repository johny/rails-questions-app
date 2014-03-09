class Game < ActiveRecord::Base

  belongs_to :quiz
  belongs_to :user

  has_many :replies

  def correct_replies_percentage
    total = quiz.questions.size.to_f
    correct = replies.where(is_correct: true).size.to_f

    return ((correct / total) * 100)

  end

  def incorrect_replies_percentage
    total = quiz.questions.size.to_f
    incorrect = replies.where(is_correct: false).size.to_f

    return ((incorrect / total) * 100)

  end




end
