
require 'spec_helper'

describe User do

  it { should have_many(:authentications) }
  it { should have_many(:statuses) }
  it { should have_many(:unpublished_statuses) }
  it { should have_many(:published_statuses) }
  it { should have_one(:setting) }

  before(:each) do
    @user = Factory(:user)
  end

  it "is valid with valid attributes" do 
    @user.should be_valid
  end

  it "should allow an email up to 255 characters" do 
    @user.email = rand(36**255).to_s(36)
    @user.should be_valid
  end

  it "should not allow an email over 255 characters" do 
    @user.email = rand(36**256).to_s(36)
    @user.should_not be_valid
  end

  it "should allow a screen name up to 255 characters" do 
    @user.screen_name = rand(36**255).to_s(36)
    @user.should be_valid
  end

  it "should not allow a screen_name over 255 characters" do 
    @user.screen_name = rand(36**256).to_s(36)
    @user.should_not be_valid
  end

  it "should allow a profile image url up to 255 characters" do 
    @user.profile_image_url = rand(36**255).to_s(36)
    @user.should be_valid
  end

  it "should not allow a profile image url over 255 characters" do 
    @user.profile_image_url = rand(36**256).to_s(36)
    @user.should_not be_valid
  end

  
end

