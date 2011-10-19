require 'spec_helper'

describe "initial 'Trickle my tweets every' setting" do
  it 'should be 2 hrs' do    
    visit root_path
    click_link('Sign in with Twitter')
    
    visit settings_path
    find_field('setting_publish_frequency').value.should == "2 hrs"
  end
end

describe "changing 'Trickle my tweets every' setting" do
  before(:each) do
    visit root_path
    click_link('Sign in with Twitter')
    
    visit settings_path
  end
  
  it "to 1 minute" do
    select('1 min', :from => 'setting_publish_frequency')
    
    pending('how to check that it is set to 1 minute?')
    pending('how to check js slider?')
  end
  
  it "to 1 hour" do
    pending('how to test setting to 1 hour?')
  end
  
  it "to 2 days" do
    pending('how to test setting to 2 days?')
  end

  it "to 1 week" do
    pending('how to test setting to 1 week?')
  end
  
  it "to 1 month" do
    pending('how to test setting to 1 month?')
  end
end