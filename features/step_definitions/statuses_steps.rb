Given /^the user "([^"]*)" has queued tweets of "([^"]*)"$/ do |user, tweets|
  tweets.split(', ').each do |tweet|
    @status = Factory(:status, 
                      :status => tweet, 
                      :user => User.find_by_nickname(user))
  end
end
 
Given /^the user "([^"]*)" has published tweets of "([^"]*)"$/ do |user, tweets|
  tweets.split(', ').each do |tweet|
    @status = Factory(:status, 
                      :status => tweet, 
                      :published_at => Time.now - 2.hours, 
                      :twitter_id => "1234", 
                      :user => User.find_by_nickname(user))
  end
end

