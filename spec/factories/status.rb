FactoryGirl.define do
  factory :status do
    association :user
    status "Poopin'"
  end
end

