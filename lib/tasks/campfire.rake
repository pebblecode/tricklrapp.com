task "campfire:stats" => :environment do
  campfire = Tinder::Campfire.new 'pebbleit', :token => '200cd9edd594519bf230b0128c4f7d59257ae1a4', :ssl_options => { :verify => false }
  room = campfire.find_room_by_id(447461)
  statuses = Status.count
  authentications = Authentication.count
  room.speak "OHAI! Stats from Tricklr"
  room.paste "Accounts: #{authentications}\nStatuses: #{statuses}"
end
