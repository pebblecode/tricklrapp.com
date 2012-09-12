require 'spec_helper'

describe Status do
  describe "fields" do
    before(:each) do
      @status = FactoryGirl.create(:status)
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
  end

  it "should be rescheduled when publish! is called" do
    status = FactoryGirl.create(:status)
    @time_now = Time.now.utc
    Time.stub!(:now).and_return(@time_now)
    status.scheduled_at.should be > Time.now.utc
    status.publish!
    status.scheduled_at.should eql(Time.now.utc)
  end

  describe "set_scheduled_at pre create hook" do
    before do
      @user = FactoryGirl.create(:user)
    end

    it "should be based on first unpublished status scheduled at" do
      unpublished_status = FactoryGirl.create(:status, :user => @user)
      unpublished_status.scheduled_at = Time.now + 3.hours
      unpublished_status.save
      unpublished_status.reload

      scheduled_time_with_interval = (unpublished_status.scheduled_at + @user.setting.interval).to_s
      status = FactoryGirl.create(:status, :user => @user)
      status.scheduled_at.to_s.should eq(scheduled_time_with_interval)
    end

    it "should be based on time now if there are no unpublished statuses" do
      time_now = Time.now
      status = FactoryGirl.create(:status, :user => @user)
      scheduled_time_with_interval = (time_now + @user.setting.interval).to_s

      status.scheduled_at.to_s.should eq(scheduled_time_with_interval)
    end

    it "should be scheduled based on the time now if the most recent tweet is scheduled in the past (eg, when resque goes down)" do
      status_in_past = FactoryGirl.create(:status, :status => "unpublished", :user => @user) # Create sets scheduled time to be 2 hours from now
      status_in_past.scheduled_at = Time.now - 10.hours
      status_in_past.save
      status_in_past.reload

      new_status = FactoryGirl.create(:status, :status => "new status", :user => @user)
      puts "Time now: #{Time.now}, unpub: #{status_in_past.scheduled_at}, new: #{new_status.scheduled_at}"
      new_status.scheduled_at.should be > Time.now
    end
  end

  describe "check_scheduled_range" do
    before do
      @status = FactoryGirl.create(:status)
    end

    describe "settings not present" do
      before do
        @default_scheduled_at = @status.scheduled_at
      end

      it "should not do anything if setting.publish_from is not present" do
        @status.user.setting.publish_from = nil
        @status.user.setting.save

        @status.scheduled_at.should eq(@default_scheduled_at)
      end

      it "should not do anything if setting.publish_until is not present" do
        @status.user.setting.publish_until = nil
        @status.user.setting.save

        @status.scheduled_at.should eq(@default_scheduled_at)
      end

      pending "should test grunt of check_scheduled_range"
    end
  end
end