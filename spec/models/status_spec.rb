require 'spec_helper'

describe Status do

  before(:each) do
    @status = Factory(:status)
  end

  it "is valid with valid attributes" do 
    @status.should be_valid
  end

  it "should allow a status up to 140 characters" do 
    @status.status = Random.alphanumeric(140)
    @status.should be_valid
  end
  
  it "should count urls as 20 characters" do
    @status.status = "http://cnn.com/#{Random.alphanumeric(150)}"
    @status.twitter_character_count.should == 20
  end

  it "should not allow a status over 140 characters" do 
    @status.status = Random.alphanumeric(141)
    @status.should_not be_valid
  end

  it "should allow a twitter_id up to 255 characters" do 
    @status.twitter_id = Random.alphanumeric(255)
    @status.should be_valid
  end

  it "should not allow a twitter_id over 255 characters" do 
    @status.twitter_id = Random.alphanumeric(256)
    @status.should_not be_valid
  end

  it "should allow a response_code up to 255 characters" do 
    @status.response_code = Random.alphanumeric(255)
    @status.should be_valid
  end

  it "should not allow a response_code over 255 characters" do 
    @status.response_code = Random.alphanumeric(256)
    @status.should_not be_valid
  end
  
  it "should be rescheduled when publish! is called" do
    @time = Time.now.utc
    Time.stub!(:now).and_return(@time)
    @status.scheduled_at.should be > Time.now.utc
    @status.publish!
    @status.scheduled_at.should eql(Time.now.utc)
  end
end

