class Status < ActiveRecord::Base

  belongs_to :user

  before_create :set_scheduled_at 
  before_update :check_scheduled_at
  after_create :queue
  before_destroy :dequeue

  validates_presence_of :status
  validates_length_of :status, :maximum => 140

  # Sets when a status is scheduled
  # If we have unpublished statuses schedule it after the last one
  # If not use the default setting
  def set_scheduled_at
    if self.user.unpublished_statuses.first.present?
      self.scheduled_at = self.user.unpublished_statuses.first.scheduled_at + self.user.setting.interval
    else
      self.scheduled_at = Time.now + self.user.setting.interval
    end
  end

  # Check if the scheduled at attribute has changed
  # and force a requeue
  def check_scheduled_at
    if self.scheduled_at_changed?
      self.requeue
    end
  end

  # Queues a tweet up for delivery via Resque Scheduler
  # This references the perform method in the SendTweet class
  # For more documentation see http://github.com/bvandenbos/resque-scheduler
  def queue
    Resque.enqueue_at(self.scheduled_at, SendTweet, self.id)
  end

  # Take a tweet off the queue
  # As there is no way to edit something that's been added
  # we need to use this too for the edit process
  def dequeue
    Resque.remove_delayed(SendTweet, self.id)
  end

  # If the scheduled_at time of a tweet is updated
  # then we need to requeue it. resque_scheduler doesn't 
  # provide a way to do this so we need to dequeue it 
  # then requeue it
  def requeue
    self.dequeue
    self.queue
  end

  # Updates scheduled at after an AJAX put
  def self.reorder_statuses(ids, user)
    scheduled_times = user.unpublished_statuses.collect {|x| x = x.scheduled_at }
    new_schedule = Hash[*ids.zip(scheduled_times).flatten]
    new_schedule.each do |s|
      Status.update_all(['scheduled_at=?', s[1]], ['id=?', s[0]])
    end
    ids.each do |id|
      Status.find(id).requeue
    end
  end
end

