require 'spec_helper'

describe "initial 'Trickle my tweets every' setting" do
  it 'should be 2 hours' do    
    visit root_path
    click_link('Sign in with Twitter')
    
    visit settings_path
    find_field('setting_publish_frequency').value.should == "2 hours"
  end
end

describe "Changing 'Trickle my tweets every' setting" do
  before(:each) do
    visit root_path
    click_link('Sign in with Twitter')
    
    visit settings_path
  end
  
  context "(in select box)" do
    it "to 1 minute" do
      select('1 minute', :from => 'setting_publish_frequency')
    
      click_button('Save')
      visit settings_path
      find_field('setting_publish_frequency').value.should == "1 minute"
    end
  
    it "to 1 hr" do
      select('1 hour', :from => 'setting_publish_frequency')
    
      click_button('Save')
      visit settings_path
      find_field('setting_publish_frequency').value.should == "1 hour"
    end
  
    it "to 2 days" do
      select('2 days', :from => 'setting_publish_frequency')
    
      click_button('Save')
      visit settings_path
      find_field('setting_publish_frequency').value.should == "2 days"
    end

    it "to 1 week" do
      select('1 week', :from => 'setting_publish_frequency')
    
      click_button('Save')
      visit settings_path
      find_field('setting_publish_frequency').value.should == "1 week"
    end
  
    it "to 4 weeks" do
      select('4 weeks', :from => 'setting_publish_frequency')
    
      click_button('Save')
      visit settings_path
      find_field('setting_publish_frequency').value.should == "4 weeks"
    end
  end
  
  context "(in javascript slider)" do
    pending('how to check js slider?')
  end
  
end