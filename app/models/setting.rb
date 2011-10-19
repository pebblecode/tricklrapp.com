class Setting < ActiveRecord::Base

  belongs_to :user

  validates :user_id,
    :presence => true, 
    :numericality => true
  validates :time_digit,   
    :numericality => true,
    :presence => true,
    :on => :update
  validates :time_unit,   
    :presence => true,
    :format =>  { 
      :with => /^(minutes|hours|days)$/, 
      :message => 'must be one of minutes, hours, or days' 
    },
    :on => :update

  def interval
    time_digit.to_f.send(time_unit).to_i
  end

  def range
    @range
  end

  def range=(value)
    @range = value
  end

  def publish_range
    publish_from.strftime("%H%M").to_i..publish_until.strftime("%H%M").to_i
  end

end

class PublishFrequencies
  @@frequencies = ['1 minute', '5 minutes', '10 minutes', '20 minutes', '30 minutes', '1 hour', '2 hours', '3 hours', '4 hours', '5 hours', '6 hours', '7 hours', '8 hours', '1 day', '2 days', '3 days', '4 days', '5 days', '6 days', '1 week', '2 weeks', '3 weeks', '1 month']
  
  @@frequency_time_regex = /^(\d+) (\w+)$/
  @@frequency_time_regex_index = 1
  @@frequency_time_unit_regex_index = 2
  
  @@frequency_default = "2 hours"
  
  def self.frequencies
    @@frequencies
  end
  
  def self.frequency_default
    @@frequency_default
  end
  
  def self.time_from_str(str)
    (self.valid_frequency? str) ? @@frequency_time_regex.match(str)[@@frequency_time_regex_index] : ''
  end
  
  # Adds a plural at the end if it is not present
  def self.time_unit_from_str(str)
    if self.valid_frequency? str
      time_unit = @@frequency_time_regex.match(str)[@@frequency_time_unit_regex_index]
      /s$/.match(time_unit) ? time_unit : time_unit + "s"
    else 
      ''
    end
  end
  
  # Note it does not validate plurals for single values
  def self.valid_frequency?(str)
    return @@frequencies.include? str
  end
  
end
