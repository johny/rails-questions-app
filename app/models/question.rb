class Question < ActiveRecord::Base

  has_many :answers
  has_and_belongs_to_many :quizzes

  validates_presence_of :title

  accepts_nested_attributes_for :answers

  def correct_answer
    answers.where(is_correct: true).first
  end

end
