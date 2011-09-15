class StatusesController < ApplicationController

  respond_to :html, :xml, :json

  before_filter :authenticate_user!
  before_filter :current_status, :except => [:index, :new, :create, :published, :sort]
  before_filter :new_status, :only => [:index, :new, :published]

  def index
    @statuses = current_user.unpublished_statuses
    @statuses_type = :unpublished
    respond_with(@statuses)
  end

  def published
    @statuses = current_user.published_statuses
    @statuses_type = :published
    render 'statuses/index'
  end

  def new
  end

  def edit
    respond_with(@status)
  end
  
  def create
    @status = Status.new(params[:status])
    @status.user = current_user
    if @status.save
      flash[:notice] = 'Hurray! Your status was scheduled for delivery'
    end
    respond_with(@status, :location => statuses_path)
  end

  def update
    if @status.update_attributes(params[:status])
      flash[:notice] = "Your status was updated"
    end        
    respond_with(@status, :location => statuses_path)
  end

  def destroy
    @status.destroy
    flash[:notice] = 'Gone! Your status is no more'
    respond_with(@status)
  end 
  
  def sort
    order = params[:status]
    Status.reorder_statuses(order, current_user)
    render :json => current_user.unpublished_statuses.reload.to_json
  end

  private 

  def current_status
    @status = current_user.statuses.find(params[:id]) 
  end

  def new_status
    @status = Status.new
  end

end
