class AuthenticationsController < Devise::OmniauthCallbacksController
  def facebook

    omni = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omni['provider'], omni['uid'])

    if authentication
      flash[:notice] = "Zalogowałeś się przez Facebook!"
      sign_in_and_redirect(authentication.user)
    elsif current_user
        flash[:notice] = "Jesteś już zalogowany!"
        redirect_to root_path
    else
      user = User.new_from_facebook_oauth(omni)
      session["devise.facebook_data"] = omni
      if user.valid?
        user.save
        flash[:notice] = "Zarejestrowałeś się przez Facebook!"
        sign_in_and_redirect(user)
      end
    end

  end

end