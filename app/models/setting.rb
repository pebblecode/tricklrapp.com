class Setting < ActiveRecord::Base

  belongs_to :user
  # before_update :calculate_interval

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

  #def time_digit
  #  @time_digit ||= case
  #    when (interval % 60) == 0 && interval <= 3599
  #      interval.to_f / 60.to_f
  #    when (interval % 3600) == 0 && interval <= 86399
  #      interval.to_f / 3600.to_f
  #    else 
  #      interval.to_f / 86400.to_f
  #  end
  #end

  #def time_digit=(value)
  #  @time_digit = value
  #end

  #def time_unit
  #  @time_unit ||= case
  #    when (interval % 60) == 0 && interval <= 3599
  #      'minutes'
  #    when (interval % 3600) == 0 && interval <= 86399
  #      'hours'
  #    else 
  #      'days'
  #  end
  #end

  #def time_unit=(value)
  #  @time_unit = value
  #end

  #def calculate_interval
  #  self.interval = self.time_digit.to_i.send(self.time_unit).to_s
  #end

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
