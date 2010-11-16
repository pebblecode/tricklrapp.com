class StatusesController < ApplicationController

  respond_to :html, :xml, :json

  before_filter :authenticate_user!, :except => :index
  before_filter :current_status, :except => [:index, :new, :create, :published, :sort]
  before_filter :new_status, :only => [:index, :new, :published]

  def index
    if current_user.present?
      @queued_statuses = current_user.unpublished_statuses
      @published_statuses = current_user.published_statuses
    else
      render :action => "pages/index"
    end
  end

  def published
    if current_user.present?
      @statuses = current_user.published_statuses
      render :index
    else
      render :action => "pages/index"
    end
  end

  def new
  end

  def edit
  end
  
  def create
    @status = Status.new(params[:status])
    @status.user_id = current_user.id
    if @status.save
      flash[:notice] = 'Hurray! Your tweet was scheduled for delivery'
    end
    respond_with(@status, :location => root_url)
  end

  def update
    if @status.update_attributes(params[:status])
      flash[:notice] = "Your tweet was updated"
    end        
    respond_with(@status) do |format|
      format.xml { render :xml => @status }
      format.json { render :json => @status }
    end
  end

  def destroy
    @status.destroy
    flash[:notice] = 'Gone! Your tweet is no more'
    respond_with(@status)
  end 

  
  def sort
    order = params[:status]
    Status.sort(order, current_user)
    render :nothing => true
  end

  private 

  def current_status
    @status = current_user.statuses.find(params[:id]) 
  end

  def new_status
    @status = Status.new
  end

end
