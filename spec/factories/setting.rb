Factory.define :setting do |f|
  f.association :user
  f.automatic true
  f.time_digit '1'
  f.time_unit 'hours'
end

