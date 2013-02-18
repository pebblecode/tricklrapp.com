
require 'spec_helper'

describe User do

  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  it "is valid with valid attributes" do
    @user.should be_valid
  end

  it "should allow a name up to 255 characters" do
    @user.name = Random.alphanumeric(255)
    @user.should be_valid
  end

  it "should not allow a name over 255 characters" do
    @user.name = Random.alphanumeric(256)
    @user.should_not be_valid
  end

  it "should allow a nickname up to 255 characters" do
    @user.nickname = Random.alphanumeric(255)
    @user.should be_valid
  end

  it "should not allow a nickname over 255 characters" do
    @user.nickname = Random.alphanumeric(256)
    @user.should_not be_valid
  end

  context "creating from Twitter" do
    it "can be created from a Hash" do
      lambda do
        User.find_for_twitter_oauth(OmniAuth.config.mock_auth[:twitter])
      end.should change(User, :count).by(1)
    end
  end

  context "Twitter created users" do
    before(:each) do
      @user = User.find_for_twitter_oauth(OmniAuth.config.mock_auth[:twitter])
    end

    it "should have settings" do
      @user.setting.should be_present
    end

    it "should import the timezone from twitter" do
      time_zone = OmniAuth.config.mock_auth[:twitter]['extra']['raw_info']['time_zone']
      @user.setting.time_zone.should equal( time_zone )
    end

    it 'should update the timezone if it changes in the twitter hash' do
      time_zone = @user.setting.time_zone
      oauth = OmniAuth.config.mock_auth[:twitter]
      oauth['extra']['raw_info']['time_zone'] = 'Tokyo'
      # If we use the same class method now to find the user, it should update the time_zone
      @user = User.find_for_twitter_oauth(oauth)
      @user.setting.time_zone.should_not equal(time_zone)
      @user.setting.time_zone.should == 'Tokyo'
    end
  end
end