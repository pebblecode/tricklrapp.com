class Status < ActiveRecord::Base

  #-------------------------------------
  # Relationships
  #-------------------------------------
  belongs_to :user

  #-------------------------------------
  # Callbacks
  #-------------------------------------
  before_create :set_scheduled_at 
  before_update :check_scheduled_at
  after_create :queue
  before_destroy :dequeue
  
  attr_accessor :jump_queue
  #-------------------------------------
  # Validations
  #-------------------------------------
  validates :status,
    :presence => true,
    :length => { :within => 1..140, :allow_blank => true }
  validates :user_id,
    :presence => true, 
    :numericality => true
  validates :twitter_id,
    :length => { :within => 1..255, :allow_blank => true }
  validates :response_code,
    :length => { :within => 1..255, :allow_blank => true }
  
  #-------------------------------------
  # Scopes
  #-------------------------------------
  scope :latest, where("published_at IS NOT NULL").limit(3).order("published_at DESC")


  # Sets when a status is scheduled
  # If we have unpublished statuses schedule it after the last one
  # If not use the default setting from Time.now
  def set_scheduled_at
    self.scheduled_at = (self.user.unpublished_statuses.first.present? ? self.user.unpublished_statuses.first.scheduled_at : Time.now) + self.user.setting.interval
    check_scheduled_range
  end

  # Check the current scheduled at range 
  # If the scheduled_at time is not in range then
  # advance it to the scheduled from time
  # TODO - add support for when publish_until is before publish_after
  # e.g from 2300 to 0100
  def check_scheduled_range
    # We need the range to be available from settings to do anything
    if self.user.setting.publish_from.present? && self.user.setting.publish_until.present?
      # We only only interested in scheduled_at times outside the range
      if !self.user.setting.publish_range.include?(self.scheduled_at.strftime("%H%M").to_i)
        # If the scheduled at time is after publish_from advance to publish_from
        if self.scheduled_at.strftime("%H%M").to_i < self.user.setting.publish_from.strftime("%H%M").to_i
          # if minutes to advance is positive it is the same day
          if minutes_to_advance(self.user.setting.publish_from, self.scheduled_at) >= 0
            self.scheduled_at = self.scheduled_at.advance(:minutes => minutes_to_advance(self.user.setting.publish_from, self.scheduled_at))
          # If not then it must be tomorrow
          else
            self.scheduled_at = self.scheduled_at.advance(:days => 1)
            self.scheduled_at = self.scheduled_at.advance(:minutes => minutes_to_advance(self.user.setting.publish_from, self.scheduled_at))
          end
        end
      end
    end
  end

  def minutes_to_advance(from, to)
    (Time.parse(from.strftime("%H:%M")) - Time.parse(to.strftime("%H:%M"))) / 60
  end

  # Check if the scheduled at attribute has changed
  # and force a requeue
  def check_scheduled_at
    if self.jump_queue
      SendTweet.perform(self.id)
    else
      self.requeue if self.scheduled_at_changed?
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
    self.dequeue; self.queue
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

