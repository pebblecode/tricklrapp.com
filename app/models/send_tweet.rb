class SendTweet < ActiveRecord::Base

  @queue = :send_tweet

  def self.perform(tweet_id)

    # Get the tweet and auth details
    @tweet = Status.find(tweet_id)
    credentials = @tweet.user.authentications.first

    # Construct OAuth request
    Twitter.configure do |config|
      config.consumer_key = TWITTER_CONSUMER_KEY
      config.consumer_secret = TWITTER_CONSUMER_SECRET
      config.oauth_token = credentials.token
      config.oauth_token_secret = credentials.secret
    end

    client = Twitter::Client.new

    # We need some error handling here if Twitter is down etc...
    response = client.update(@tweet.status)

    # If we are ok log the details
    @tweet.update_attributes(
      :twitter_id => response.id,
      :published_at => response.created_at
    )
  end

end
