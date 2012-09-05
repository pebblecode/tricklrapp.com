FactoryGirl.define do
  factory :setting do
    association :user
    automatic true
    time_digit '1'
    time_unit 'hours'
    time_zone 'London'
  end
end

