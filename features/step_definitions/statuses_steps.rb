Given /^there are queued statuses of "([^"]*)"$/ do |statuses|
  statuses.split(', ').each do |status|
    @status = Factory(:status, :status => status)
  end
end
 
Given /^there are published statuses of "([^"]*)"$/ do |statuses|
  statuses.split(', ').each do |status|
    @status = Factory(:status, :status => status, :published_at => Time.now, :twitter_id => "1234")
  end
end

