class Quiz < ActiveRecord::Base

  has_and_belongs_to_many :questions

  has_many :games
  has_many :users, through: :games

  include Workflow
  workflow do

    # Model is new, fresh created and awaiting moderation
    state :pending do
      event :publish, transitions_to: :active
    end

    # Model offer is published and visible on site
    state :active do
      event :unpublish, transitions_to: :pending
      event :expire, transitions_to: :expired
    end

    # Model offer expired after 30 days, visible in archive
    state :expired

    # Old jobs, imported and archived
    state :archived
  end

  scope :daily, -> { with_active_state.first}

  def self.has_daily_quiz_for user
    quiz = self.daily

    if user.quizzes.include? quiz
      return false
    else
      return quiz.first
    end

  end

end
