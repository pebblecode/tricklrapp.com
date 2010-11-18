Factory.define :status do |f|
  f.association :user, :factory => :user
  f.status 'Some BS'
end

