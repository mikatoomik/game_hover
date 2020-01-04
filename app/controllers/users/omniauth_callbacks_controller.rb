class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.from_facebook(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentification
    else
      session['devise.facebook'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
  def github
    @user = User.from_github(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentification
    else
      session['devise.github'] = request.env['omniauth.auth']
      raise
      redirect_to new_user_registration_url
    end
  end
end
