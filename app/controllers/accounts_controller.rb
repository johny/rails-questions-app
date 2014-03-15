class AccountsController < ApplicationController

  def index
  end

  def settings
  end


  def avatar
    auth = current_user.authentications.find(params[:id])

    if auth && auth.image
      current_user.avatar_remote_url = auth.image
      current_user.save
      flash[:notice] = "Twój avatar został zaktualizowany!"
      redirect_to action: :index
    else
      flash.now[:error] = "Nie udało się pobrać avatara!"
      render action: :index
    end



  end

end
