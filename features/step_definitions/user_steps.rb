# This assumes OAuth has been successful
# Struggling to test OAuth..
Given /^I am logged into Tricklr as "([^"]*)"$/ do |user|
  @user = Factory.create(:user, :nickname => user)
  login_as @user
end

