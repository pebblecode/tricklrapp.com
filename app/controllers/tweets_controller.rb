class TweetsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @tweet = Tweet.new
  end

  def new
    @tweet = Tweet.new
  end

  def edit
  end
  
  def create
    @tweet = Tweet.new(params[:tweet])
    @tweet.user_id = current_user
    if @tweet.save
      flash[:notice] = 'Hurray! Your tweet was scheduled for delivery'
      redirect_to tweets_path
    else
      render :action => 'new'
    end
  end

  def update
  end

  def destroy
  end

end
