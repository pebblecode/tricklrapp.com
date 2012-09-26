class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def twitter
    @user = User.find_for_twitter_oauth(env['omniauth.auth'], current_user)

    if @user.persisted?
      flash[:notice] = if settings_url == request.env['omniauth.origin']
          SettingsController.update_flash_msg
        else
          I18n.t 'devise.omniauth_callbacks.success', kind: 'Twitter'
        end
      @user.remember_me = true
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.failure', kind: 'Twitter', reason: 'User not found'
      redirect_to new_user_session_path
    end
  end


  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

end
