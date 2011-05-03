
require 'spec_helper'

describe SendTweet do

  it { should validate_presence_of(:) }
  it { should validate_numericality_of(:user_id) }
  it { should validate_presence_of(:status) }

  before(:each) do
    @status = Factory(:status)
  end

  it "is valid with valid attributes" do 
    @status.should be_valid
  end

  it "should allow a status up to 140 characters" do 
    @status.status = rand(36**140).to_s(36)
    @status.should be_valid
  end

  it "should not allow a status over 140 characters" do 
    @status.status = rand(36**141).to_s(36)
    @status.should_not be_valid
  end

  it "should allow a twitter_id up to 255 characters" do 
    @status.twitter_id = rand(36**255).to_s(36)
    @status.should be_valid
  end

  it "should not allow a twitter_id over 255 characters" do 
    @status.twitter_id = rand(36**256).to_s(36)
    @status.should_not be_valid
  end

  it "should allow a response_code up to 255 characters" do 
    @status.response_code = rand(36**255).to_s(36)
    @status.should be_valid
  end

  it "should not allow a response_code over 255 characters" do 
    @status.response_code = rand(36**256).to_s(36)
    @status.should_not be_valid
  end
  
end

