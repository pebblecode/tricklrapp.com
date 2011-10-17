require 'spec_helper'

describe "A user submitting a new tweet" do
  before(:each) do
    visit root_path
    click_link('Sign in with Twitter')
  end
    
  it "should be able to add a tweet" do
    fill_in('status_status', :with => 'buildin da internetz')
    click_button('Trickle it!')
    
    page.html.should match /Hurray! Your tweet was scheduled for delivery/
  end
    
  it "should see the tweet queued" do
    visit root_path
    fill_in('status_status', :with => 'can haz cheezburger?, oh hai')
    click_button('Trickle it!')
    
    within(:css, "ul#queued_statuses li") do
      page.html.should match /can haz cheezburger\?, oh hai/
    end
  end
  
  it "should see an empty tweet text box" do
    visit root_path
    fill_in('status_status', :with => 'hello, I am queued')
    click_button('Trickle it!')

    find_field('status[status]').value.should == ""
  end
    
  it "should be able to submit another tweet" do
    visit root_path
    fill_in('status_status', :with => 'hello, I am queued')
    click_button('Trickle it!')

    fill_in('status_status', :with => 'another tweet')
    click_button('Trickle it!')
    
    within(:css, "ul#queued_statuses li") do
      page.html.should match /hello, I am queued/
      page.html.should match /another tweet/
    end
  end
  
  # Cucumber feature:
  # Scenario: Viewing published tweets
  #     Given the user "shapeshed" has published tweets of "I'm in ur computer testin ur app, can haz fish plz?"
  #     When I go to the published page
  #     Then I should see "I'm in ur computer testin ur app"
  #     And I should see "can haz fish plz?"
  it "should be able to view published tweets" do
    pending("have to figure out how to test for a published tweet")
    # @status = Factory(:status, 
    #                   :status => tweet, 
    #                   :published_at => Time.now - 2.hours,
    #                   :twitter_id => "1234", 
    #                   :user => User.find_by_nickname(user))
    
    # visit published_path
    # page.html.should match /I'm in ur computer testin ur app/
    # page.html.should match /can haz fish plz?/
  end

  it "should be able to delete a queued tweet" do
    visit root_path
    fill_in('status_status', :with => 'plz delete thnx')
    click_button('Trickle it!')
    
    click_button('Destroy')
    
    page.html.should match /Gone! Your tweet is no more/
    page.html.should_not match /plz delete thnx/
  end

  it "should be able to edit a queued tweet" do
    visit root_path
    fill_in('status_status', :with => 'edit me thnx')
    click_button('Trickle it!')
    
    click_link('Edit')
    fill_in('status_status', :with => 'ok we iz edited')
    click_button('Trickle it!')
    
    page.html.should match /Your tweet was updated/
    page.html.should_not match /edit me thnx/
    page.html.should match /ok we iz edited/
  end
  
end

describe "A user entering erroneous tweets" do
  before(:each) do
    visit root_path
    click_link('Sign in with Twitter')
    fill_in('status_status', :with => 'hello, I am queued')
    click_button('Trickle it!')
    page.html.should match /hello, I am queued/
  end
  
  it "should see queued trickles when tweet is empty" do
    visit root_path
    fill_in('status_status', :with => '')
    click_button('Trickle it!')
    page.html.should match /Tweet can't be blank/
    page.html.should match /hello, I am queued/
  end
  
  it "should see queued trickles when tweet is over 140 characters" do
    visit root_path
    fill_in('status_status', :with => 'This is a very long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long tweet')
    click_button('Trickle it!')
    page.html.should match /Tweet is too long \(maximum is 140 characters\)/
    page.html.should match /hello, I am queued/
  end
end
