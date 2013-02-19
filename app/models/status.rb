class Status < ActiveRecord::Base
  MAX_STATUS_LENGTH = 140
  TCO_SIZE = 20
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

  attr_accessor :publish
  #-------------------------------------
  # Validations
  #-------------------------------------
  validates :status,
    :presence => true
  validate  :validate_status_length
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
    first_unpublished_status = self.user.unpublished_statuses.first
    start_time = if first_unpublished_status.present? and first_unpublished_status.scheduled_at > Time.now
                   first_unpublished_status.scheduled_at
                 else
                   Time.now
                 end

    self.scheduled_at = start_time + self.user.setting.interval
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

  # Remove from the queue and requeue it for "now", jumping the queue.
  def publish!
    self.dequeue
    self.scheduled_at = Time.now.utc
    self.save
    Resque.enqueue(SendTweet, self.id)
  end

  # Check if the scheduled at attribute has changed
  # and force a requeue
  def check_scheduled_at
    self.requeue if self.scheduled_at_changed?
  end

  # Queues a tweet up for delivery via Resque Scheduler
  # This references the perform method in the SendTweet class
  # For more documentation see http://github.com/bvandenbos/resque-scheduler
  def queue
    self.schedule(self.scheduled_at)
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

  def twitter_character_count
    # links are converted to t.co
    count = status.length
    links = URI.extract(status, ['http','https'])
    if links.any?
      links_length = links.join('').length
      count = (count - links_length) + (links.count * TCO_SIZE)
    end
    return count
  end
  protected
    # Schedules a status to be published, accepts the time
    def schedule(time)
      Resque.enqueue_at(time, SendTweet, self.id)
    end
    def validate_status_length
      if twitter_character_count > MAX_STATUS_LENGTH
        errors.add(:status, "is too long - maximum is #{MAX_STATUS_LENGTH} characters, links count as #{TCO_SIZE} characters)")
      end
    end
end

