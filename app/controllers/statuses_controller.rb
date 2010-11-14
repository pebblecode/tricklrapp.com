class StatusesController < ApplicationController

  before_filter :authenticate_user!, :except => :index
  before_filter :current_status, :except => [:index, :new, :create, :published]
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
      redirect_to root_path
    else
      render :action => 'new'
    end
  end

  def update
    if @status.update_attributes(params[:status])
      flash[:notice] = "Your tweet was updated"
      redirect_to root_path
    else 
      redirect_to root_path
      render :action => 'edit'
    end        
  end

  def destroy
    @status.destroy
    flash[:notice] = 'Gone! Your tweet is no more'
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render false }
    end
  end 

  private 

  def current_status
    @status = current_user.statuses.find(params[:id]) 
  end

  def new_status
    @status = Status.new
  end

end
