class HomeController < ApplicationController

  # for not logged users
  def index
    redirect_to :dashboard if user_signed_in?
  end

  def dashboard
    @daily_quiz = Quiz.has_daily_quiz_for current_user
  end

  def rankings
    @users = User.ranking
  end

end
