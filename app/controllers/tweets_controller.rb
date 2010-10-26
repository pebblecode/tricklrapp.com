class TweetsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :current_tweet, :except => [:index, :new, :index]
  before_filter :new_tweet, :only => [:index, :new]

  def index
    @tweets = current_user.tweets
  end

  def new
  end

  def edit
  end
  
  def create
    @tweet = Tweet.new(params[:tweet])
    @tweet.user_id = current_user.id
    if @tweet.save
      flash[:notice] = 'Hurray! Your tweet was scheduled for delivery'
      redirect_to tweets_path
    else
      render :action => 'new'
    end
  end

  def update
    if @tweet.update_attributes(params[:tweet])
      flash[:notice] = "Your tweet was updated"
      redirect_to tweets_path
    else 
      render :action => 'edit'
    end        
  end

  def destroy
    @tweet.destroy
    flash[:notice] = 'Gone! Your tweet is no more'
    redirect_to :back
  end 

  private 

  def current_tweet
    @tweet = current_user.tweets.find(params[:id]) 
  end

  def new_tweet
    @tweet = Tweet.new
  end

end
