class SendTweet < ActiveRecord::Base
  @queue = :tweet
  @token = "36670724-itwLyz641g76JitN9CTIpEw5Dtqg7NLU7uzZ7aPXO"
  @secret = "OcKQ907H0KUjV7qzbWNGNYZEBDsjjB5rPXtyTzi6c"
  def self.perform(token, secret, tweet)
    #puts tweet
    oauth = Twitter::OAuth.new(TWITTER_CONSUMER_KEY, TWITTER_CONSUMER_SECRET)
    oauth.authorize_from_access(token, secret)
    client = Twitter::Base.new(oauth)
    client.update(tweet)
  end
end
