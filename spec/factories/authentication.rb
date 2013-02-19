FactoryGirl.define do
  factory :authentication do
    association :user
    provider 'twitter'
    uid '36670724'
    token '36670724-itwLyz641g76JitN9CTIpEw5Dtqg7NLU7uzZ7aPXO'
    secret 'OcKQ907H0KUV7qzbWNGNYZEBDsjjB5rPXtyTzi6c'
  end
end

