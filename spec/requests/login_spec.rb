require 'spec_helper'

describe "Login integration tests" do
  it "should show a link to Twitter when not logged in " do
    visit root_path
    page.html.should match /Sign in with Twitter/
  end

  it "should correctly log in a user via twitter" do
    visit root_path
    click_link('Sign in with Twitter')
    page.html.should match /Add to Queue/
  end

  it "should correctly log out a user" do
    visit root_path
    click_link('Sign in with Twitter')
    page.html.should match /Add to Queue/
    click_link('Logout')
    page.html.should match /Sign in with Twitter/
  end
  
  it "should redirect to homepage on statuses page if logged out" do
    visit root_path
    click_link('Sign in with Twitter')
    click_link('Logout')
    
    visit statuses_path
    page.current_path.should match root_path
  end
  
  it "should redirect to homepage on sign in page if logged out" do
    visit root_path
    click_link('Sign in with Twitter')
    click_link('Logout')
    
    visit new_user_session_path
    page.current_path.should match root_path
  end
  
end

describe "Login specs" do
  it "should create a new user and a new authentication if the user never logged before " do
    visit root_path
    click_link('Sign in with Twitter')
    Authentication.count.should eql 1
    User.count.should eql 1
  end

  it "should not create a new authentication if the user logged before" do
    other_user = Factory(:user, :name => "Somebodoy", :nickname => "some")
    auth = Factory(:authentication)
    visit root_path
    click_link('Sign in with Twitter')
    Authentication.count.should eql 1
    User.count.should eql 2
  end
end

