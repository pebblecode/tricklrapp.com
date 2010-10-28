class StatusesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :current_status, :except => [:index, :new, :index]
  before_filter :new_status, :only => [:index, :new]

  def index
    @statuses = current_user.statuses
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
      redirect_to statuses_path
    else
      render :action => 'new'
    end
  end

  def update
    if @status.update_attributes(params[:status])
      flash[:notice] = "Your tweet was updated"
      redirect_to root_path
    else 
      render :action => 'edit'
    end        
  end

  def destroy
    @status.destroy
    flash[:notice] = 'Gone! Your tweet is no more'
    redirect_to :back
  end 

  private 

  def current_status
    @status = current_user.statuses.find(params[:id]) 
  end

  def new_status
    @status = Status.new
  end

end
