class SettingsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :current_setting
  before_filter :get_publish_frequency_options
  before_filter :check_browser

  def index
  end

  def update
    publish_frequency = params[:setting_publish_frequency]
    if PublishFrequencies.valid_frequency? publish_frequency
      @setting.time_digit = PublishFrequencies.time_from_str(publish_frequency)
      @setting.time_unit = PublishFrequencies.time_unit_from_str(publish_frequency)
    end

    if @setting.update_attributes(params[:setting])
      flash[:notice] = "Your settings were updated"
      # Redirect to login, so that the time zone is updated
      redirect_to user_omniauth_authorize_path(:twitter)
    else
      render :action => 'index'
    end        
  end

  private

  def current_setting
    @setting = current_user.setting
  end

  def get_publish_frequency_options
    @publish_frequencies = PublishFrequencies.frequencies
    @publish_frequencies_default = PublishFrequencies.frequency_default_from_setting(@setting)
  end

end