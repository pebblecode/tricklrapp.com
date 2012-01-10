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
  
  it "should be able to jump the queue" do
    visit root_path
    fill_in('status_status', :with => 'Scumbag status: gets on the queue, jumps it')
    click_button('Trickle it!')
    page.html.should match /Scumbag status: gets on the queue, jumps it/
    # click_button('Jump the queue!')
    # page.html.should match /Cool, we jumped the queue and tweeted your status/
    # page.html.should_not match /Scumbag status: gets on the queue, jumps it/
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
