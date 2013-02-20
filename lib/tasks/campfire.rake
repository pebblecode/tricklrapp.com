task "campfire:stats" => :environment do
  campfire = Tinder::Campfire.new 'pebbleit', :token => '200cd9edd594519bf230b0128c4f7d59257ae1a4', :ssl_options => { :verify => false }
  room = campfire.find_room_by_id(447461)
  statuses = Status.count
  authentications = Authentication.count

  yesterday = Time.now - 1.days
  logins_in_last_day = User.where("updated_at > ?", yesterday).count # NOTE: user gets updated on log out as well as login
  statuses_in_last_day = Status.where("published_at > ?", yesterday).count

  room.speak "OHAI! Stats from Tricklr"
  room.paste "Accounts: #{authentications}\nStatuses: #{statuses}\nLogins in last 24hrs: #{logins_in_last_day}\nStatuses in last 24hrs: #{statuses_in_last_day}"
end
