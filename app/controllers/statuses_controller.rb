class StatusesController < ApplicationController

  respond_to :html, :xml, :json

  before_filter :authenticate_user!
  before_filter :current_status, :except => [:index, :new, :create, :sort]
  before_filter :new_status, :only => [:index, :new]
  before_filter :check_browser

  before_filter :get_unpublished_statuses, :only => [:new, :index, :create]
  
  def index
    respond_with(@statuses)
  end

  def new
    render 'statuses/index'
  end

  def edit
    respond_with(@status)
  end
  
  def create
    @status = Status.new(params[:status])
    @status.user = current_user
    if @status.save
      flash[:notice] = 'Hurray! Your tweet was scheduled for delivery'
      # Clear status message for form refresh
      @status.status = nil
      redirect_to statuses_url
    else
      render 'statuses/index'
    end
  end

  def update
    if @status.update_attributes(params[:status])
      flash[:notice] = "Your tweet was updated"
    end        
    respond_with(@status, :location => statuses_path)
  end

  def destroy
    @status.destroy
    flash[:notice] = 'Gone! Your tweet is no more'
    respond_with(@status)
  end 
  
  def sort
    order = params[:status]
    Status.reorder_statuses(order, current_user)
    render :json => { :time => Time.now, :statuses => current_user.unpublished_statuses.reload.to_json }
  end
  
  def publish
      @status = Status.find(params[:id])
      @status.publish!
      flash[:notice] = "Cool, your tweet has been rescheduled"
      respond_with(@status, :location => statuses_path)
  rescue ActiveRecord::RecordNotFound
    @status = nil
    flash[:notice] = "Could not find that status to publish."
    redirect_to statuses_path
  end

  private 

  def current_status
    @status = current_user.statuses.find(params[:id]) 
  end

  def new_status
    @status = Status.new
  end
  
  def get_unpublished_statuses
    @statuses = current_user.unpublished_statuses
    @statuses_type = :unpublished
  end

end
