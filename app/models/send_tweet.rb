class SendTweet < ActiveRecord::Base

  @queue = :send_tweet

  def self.perform(token, secret, tweet)
    # Construct OAuth request
    oauth = Twitter::OAuth.new(TWITTER_CONSUMER_KEY, TWITTER_CONSUMER_SECRET)
    oauth.authorize_from_access(token, secret)
    client = Twitter::Base.new(oauth)

    # We need some error handling here if Twitter is down etc...
    response = client.update(tweet['tweet']['status'])
    #logger.info(response)
    @tweet = Tweet.find(tweet['tweet']['id'])
    @tweet.update_attributes(
      :twitter_id => response.id,
      :published_at => response.created_at
    )
  end

end
