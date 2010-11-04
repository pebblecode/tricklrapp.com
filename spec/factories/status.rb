Factory.define :status do |f|
  f.association :user_id, :factory => :user
  f.status 'Some BS'
end

