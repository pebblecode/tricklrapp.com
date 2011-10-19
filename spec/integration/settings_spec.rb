require 'spec_helper'

describe "Initial 'Trickle my tweets every' setting" do
  it 'should be 2 hours' do    
    visit root_path
    click_link('Sign in with Twitter')
    
    visit settings_path
    find_field('setting_publish_frequency').value.should == "2 hours"
  end
end

describe "Save 'Trickle my tweets every' settings" do
  before(:each) do
    visit root_path
    click_link('Sign in with Twitter')
    
    visit settings_path
  end
  
  context "when selecting the following (from the select box):" do
    it "1 minute" do
      select('1 minute', :from => 'setting_publish_frequency')
    
      click_button('Save')
      visit settings_path
      find_field('setting_publish_frequency').value.should == "1 minute"
    end
  
    it "1 hour" do
      select('1 hour', :from => 'setting_publish_frequency')
    
      click_button('Save')
      visit settings_path
      find_field('setting_publish_frequency').value.should == "1 hour"
    end
  
    it "2 days" do
      select('2 days', :from => 'setting_publish_frequency')
    
      click_button('Save')
      visit settings_path
      find_field('setting_publish_frequency').value.should == "2 days"
    end

    it "1 week" do
      select('1 week', :from => 'setting_publish_frequency')
    
      click_button('Save')
      visit settings_path
      find_field('setting_publish_frequency').value.should == "1 week"
    end
  
    it "4 weeks" do
      select('4 weeks', :from => 'setting_publish_frequency')
    
      click_button('Save')
      visit settings_path
      find_field('setting_publish_frequency').value.should == "4 weeks"
    end
  end
  
  context "when selecting the following (from the javascript slider):" do
    pending('how to check js slider?')
  end
  
end