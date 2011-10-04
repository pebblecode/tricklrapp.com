require 'spec_helper'

describe "A user entering erroneous statuses" do
  before(:each) do
    visit root_path
    click_link('Sign in with Twitter')
    fill_in('status_status', :with => 'hello, I am queued')
    click_button('Trickle it!')
    page.html.should match /hello, I am queued/
  end
  
  it "should see queued trickles when status is empty" do
    visit root_path
    fill_in('status_status', :with => '')
    click_button('Trickle it!')
    page.html.should match /Status can't be blank/
    page.html.should match /hello, I am queued/ # Shows the Edit Status page, with no queued trickles for some reason
  end
  
  it "should see queued trickles when status is over 140 characters" do
    visit root_path
    fill_in('status_status', :with => 'This is a very long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long status')
    click_button('Trickle it!')
    page.html.should match /Status is too long \(maximum is 140 characters\)/
    page.html.should match /hello, I am queued/ # Shows the Edit Status page, with no queued trickles for some reason
  end
end

describe "A user submitting a new status" do
  before(:each) do
    visit root_path
    click_link('Sign in with Twitter')
  end
    
  it "should see the status queued" do
    visit root_path
    fill_in('status_status', :with => 'hello, I am queued')
    click_button('Trickle it!')
    
    within(:css, "ul#queued_statuses li") do
      page.html.should match /hello, I am queued/
    end
  end
  
  it "should see see an empty status text box" do
    visit root_path
    fill_in('status_status', :with => 'hello, I am queued')
    click_button('Trickle it!')

    find_field('status[status]').value.should == ""
  end
    
end