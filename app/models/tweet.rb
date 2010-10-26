class Tweet < ActiveRecord::Base
  belongs_to :user
  after_create :queue_tweet

  validates_presence_of :status

  # Queues a tweet up for delivery via Resque Scheduler
  # This references the perform method in the SendTweet class
  # For more documentation see http://github.com/bvandenbos/resque-scheduler
  def queue_tweet
    credentials = self.user.authentications.first
    Resque.enqueue_at(2.hours.from_now, SendTweet, credentials.token, credentials.secret, self)
    self.scheduled_at = 2.hours.from_now
    self.save!
  end
end

