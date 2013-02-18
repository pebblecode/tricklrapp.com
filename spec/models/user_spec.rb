
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

    context "when twitter hash changes" do
      before(:each) do
        @new_nickname = 'hobobobo'
        @new_token = 'some_new_token'
        @new_secret = 'some_new_secret'
        @new_time_zone = 'Tokyo'

        oauth = OmniAuth.config.mock_auth[:twitter]
        oauth['info']['nickname'] = @new_nickname
        oauth['credentials']['token'] = @new_token
        oauth['credentials']['secret'] = @new_secret
        oauth['extra']['raw_info']['time_zone'] = @new_time_zone

        @looked_up_user = User.find_for_twitter_oauth(oauth)
      end

      it 'should update the nickname' do
        @looked_up_user.nickname.should == @new_nickname
      end

      it 'should update the timezone' do
        @looked_up_user.setting.time_zone.should == @new_time_zone
      end

      context 'for omniauth login credentials' do
        it 'should update for token' do
          @looked_up_user.authentications.first.token.should == @new_token
        end

        it 'should update for secret' do
          @looked_up_user.authentications.first.secret.should == @new_secret
        end
      end

    end
  end
end