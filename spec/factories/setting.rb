Factory.define :setting do |f|
  f.association :user_id, :factory => :user
  f.automatic true
  f.time_digit '1'
  f.time_unit 'hours'
end

