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
      :with => /^(mins|hours|days|weeks)$/,
      :message => 'must be one of mins, hours, days, weeks'
    },
    :on => :update

  def interval
    unit = 'minutes' if time_unit == 'mins'
    unit ||= time_unit
    time_digit.to_f.send(unit).to_i
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
  @@frequencies = ['30 mins', '1 hour', '2 hours', '4 hours', '6 hours', '8 hours', '12 hours', '1 day', '2 days', '1 week']
  
  @@frequency_time_regex = /^(\d+) (\w+)$/
  @@frequency_time_regex_index = 1
  @@frequency_time_unit_regex_index = 2
  
  @@frequency_default = "2 hours"
  
  def self.frequencies
    @@frequencies
  end
  
  def self.frequency_default_from_setting(setting)
    if setting
      time_unit = (setting.time_digit == 1) ? setting.time_unit.singularize : setting.time_unit
      default_value = "#{setting.time_digit.to_i} #{time_unit}"
      
      (self.valid_frequency? default_value) ? default_value : @@frequency_default
    else
      @@frequency_default
    end
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
