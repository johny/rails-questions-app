class Game < ActiveRecord::Base

  # Game is just a record of Player playing with Quiz (daily for now)
  # Rules are as follow:
  # 10 seconds for each question
  # 10 points for each correct answer
  # + time left bonus for each correct answer
  # One of question could have random 3-5 %chances of being bonus 10-100%

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


  def count_reply! (reply)

    if reply.is_correct
      self.score += Rules.score_for_correct_answer
      self.save!
    end

  end




end
