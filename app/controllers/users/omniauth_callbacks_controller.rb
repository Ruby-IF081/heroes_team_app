class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    generic_callback('facebook')
  end

  def google_oauth2
    generic_callback('google')
  end

  def generic_callback(provider)
    @user = User.from_omniauth(omniauth_hash)
    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = omniauth_hash.except(:extra)
      redirect_to new_user_registration_path
    end
  end

  def omniauth_hash
    request.env["omniauth.auth"]
  end

  def failure
    redirect_to root_path
  end
end
