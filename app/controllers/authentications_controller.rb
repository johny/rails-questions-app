class AuthenticationsController < Devise::OmniauthCallbacksController

  def facebook

    oauth_callback(request.env["omniauth.auth"])

  end

  def google_oauth2

    oauth_callback(request.env["omniauth.auth"])

  end

  private

    def oauth_callback(omni)

      authentication = Authentication.where({provider: omni['provider'], uid: omni['uid']}).take

      if authentication
        flash[:notice] = "Witamy w serwisie!"
        sign_in_and_redirect(authentication.user)
      elsif current_user
        flash[:notice] = "Jesteś już zalogowany!"
        redirect_to root_path
      else
        user = User.find_or_create_from_oauth(omni)
        if user
          session["devise.omni_data"] = omni
          flash[:notice] = "Witamy w serwisie!"
          sign_in_and_redirect(user)
        end
      end
    end



end