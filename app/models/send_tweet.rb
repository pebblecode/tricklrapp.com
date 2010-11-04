class SendTweet < ActiveRecord::Base

  @queue = :send_tweet

  def self.perform(tweet_id)

    logger.info(tweet_id)
    # Get the tweet and auth details
    @tweet = Status.find(tweet_id)
    credentials = @tweet.user.authentications.first

    # Construct OAuth request
    oauth = Twitter::OAuth.new(TWITTER_CONSUMER_KEY, TWITTER_CONSUMER_SECRET)
    oauth.authorize_from_access(credentials.token, credentials.secret)
    client = Twitter::Base.new(oauth)

    # We need some error handling here if Twitter is down etc...
    response = client.update(@tweet.status)

    # If we are ok log the details
    @tweet.update_attributes(
      :twitter_id => response.id,
      :published_at => response.created_at
    )
  end

end
