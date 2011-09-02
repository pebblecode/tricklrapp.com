Given /^the user "([^"]*)" has queued statuses of "([^"]*)"$/ do |user, statuses|
  statuses.split(', ').each do |status|
    @status = Factory(:status, 
                      :status => status, 
                      :user => User.find_by_nickname(user))
  end
end
 
Given /^the user "([^"]*)" has published statuses of "([^"]*)"$/ do |user, statuses|
  statuses.split(', ').each do |status|
    @status = Factory(:status, 
                      :status => status, 
                      :published_at => Time.now - 2.hours, 
                      :twitter_id => "1234", 
                      :user => User.find_by_nickname(user))
  end
end

