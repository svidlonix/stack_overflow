class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_or_create_for_auth(request.env['omniauth.auth'])
    sign_in_and_redirect @user, event: :authentication
    set_flash_message(:notice, :success, kind: 'Facebook')
  end
end
