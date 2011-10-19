class SettingsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :current_setting
  before_filter :get_publish_frequency_options

  def index
  end

  def update
    if @setting.update_attributes(params[:setting])
      flash[:notice] = "Your settings were updated"
      redirect_to statuses_path
    else 
      render :action => 'index'
    end        
  end

  private 

  def current_setting
    @setting = current_user.setting
  end

  def get_publish_frequency_options
    @publish_frequencies = ['1 mins', '5 mins', '10 mins', '20 mins', '30 mins', '1 hr', '2 hrs', '3 hrs', '4 hrs', '5 hrs', '6 hrs', '7 hrs', '8 hrs', '1 day', '2 days', '3 days', '4 days', '5 days', '6 days', '1 wk', '2 wk', '3 wk', '1 mth']
    @publish_frequencies_default = "2 hrs"
  end

end
