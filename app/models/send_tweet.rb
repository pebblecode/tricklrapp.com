class SendTweet

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

    # NOTE for more on error codes see 
    # https://dev.twitter.com/docs/error-codes-responses
    begin
      response = client.update(@tweet.status)
      @tweet.update_attributes(
        :twitter_id => response.id,
        :published_at => response.created_at
      )
    # Raised when Twitter returns the HTTP status code 502
    rescue Twitter::Error::BadGateway
      @tweet.scheduled_at = Time.now.utc + 5.minutes
      @tweet.save!
      @tweet.requeue
    # TODO - handle these error sceanarios
    # Raised when Twitter returns the HTTP status code 400
    # rescue Twitter::Error::BadRequest
    # Raised when Twitter returns a 4xx HTTP status code
    # rescue Twitter::Error::ClientError
    # Raised when Twitter returns the HTTP status code 420
    # rescue Twitter::Error::EnhanceYourCalm
    # Raised when Twitter returns the HTTP status code 403
    # rescue Twitter::Error::Forbidden
    # Raised when Twitter returns the HTTP status code 500
    # rescue Twitter::Error::InternalServerError
    # Raised when Twitter returns the HTTP status code 406
    # rescue Twitter::Error::NotAcceptable
    # Raised when Twitter returns the HTTP status code 404
    # rescue Twitter::Error::NotFound
    # Raised when Twitter returns a 5xx HTTP status code
    # rescue Twitter::Error::ServerError
    # Raised when Twitter returns the HTTP status code 503
    # rescue Twitter::Error::ServiceUnavailable
    # Raised when Twitter returns the HTTP status code 401
    # rescue Twitter::Error::Unauthorized
    # rescue Errno::ENOENT
    # Raised when there is a timeout
    # rescue Errno::ETIMEDOUT
    # Raised when the connection is reset 
    # rescue Errno::ECONNRESET
    # Raised when there is a standard error
    # rescue
    # Raised when there is a generic Exception
    # rescue Exception
    end
  end
end
