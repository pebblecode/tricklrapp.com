require 'spec_helper'

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

describe "A user submitting a new tweet" do
  before(:each) do
    visit root_path
    click_link('Sign in with Twitter')
  end
    
  it "should see the tweet queued" do
    visit root_path
    fill_in('status_status', :with => 'hello, I am queued')
    click_button('Trickle it!')
    
    within(:css, "ul#queued_statuses li") do
      page.html.should match /hello, I am queued/
    end
  end
  
  it "should see see an empty tweet text box" do
    visit root_path
    fill_in('status_status', :with => 'hello, I am queued')
    click_button('Trickle it!')

    find_field('status[status]').value.should == ""
  end
    
end