# This assumes OAuth has been successful
# Struggling to test OAuth..
Given /^I am logged into Tricklr$/ do
  @user = Factory.create(:user)
  login_as @user
end

