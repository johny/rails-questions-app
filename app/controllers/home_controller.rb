class HomeController < ApplicationController

  # for not logged users
  def index
    redirect_to :dashboard if user_signed_in?
  end

  def dashboard
    @quiz = Quiz.daily
  end

end
