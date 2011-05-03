Factory.define :status do |f|
  f.association :user
  f.status 'Some BS'
end

