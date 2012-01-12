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
    it "30 mins" do
      select('30 mins', :from => 'setting_publish_frequency')
    
      click_button('Save')
      visit settings_path
      find_field('setting_publish_frequency').value.should == "30 mins"
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
  
  end
  
  context "when selecting the following (from the javascript slider):" do
    pending('how to check js slider?')
  end
  
end

describe "Saved 'Trickle my tweets every' setting changes trickle frequency" do
  
  describe 'for trickling every 1 week' do
    it {
      visit root_path
      click_link('Sign in with Twitter')

      visit settings_path
      select('1 week', :from => 'setting_publish_frequency')
      click_button('Save')

      visit root_path
      fill_in('status_status', :with => 'you be tweeted in 1 week')
      click_button('Add to Queue')

      page.html.should match /trickling in 7 days/
    }
    
    it 'for 3 trickles' do
      visit root_path
      click_link('Sign in with Twitter')

      visit settings_path
      select('1 week', :from => 'setting_publish_frequency')
      click_button('Save')

      visit root_path
      fill_in('status_status', :with => 'you be tweeted in 1 week')
      click_button('Add to Queue')

      page.html.should match /trickling in 7 days/
      
      visit root_path
      fill_in('status_status', :with => 'you be tweeted in 2 week')
      click_button('Add to Queue')

      page.html.should match /trickling in 14 days/
      
      visit root_path
      fill_in('status_status', :with => 'you be tweeted in 3 week')
      click_button('Add to Queue')

      page.html.should match /trickling in 21 days/
    end
  end

  pending 'changing settings between different trickles'
  
end