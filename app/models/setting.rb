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
