require 'spec_helper'

describe Authentication do

  it { should belong_to(:user) }
  it { should validate_presence_of(:user_id) }
  it { should validate_numericality_of(:user_id) }
  it { should validate_presence_of(:provider) }
  it { should validate_presence_of(:uid) }
  it { should validate_presence_of(:token) }
  it { should validate_presence_of(:secret) }

  before(:each) do
    @authentication = Factory(:authentication)
  end

  it "is valid with valid attributes" do 
    @authentication.should be_valid
  end

  it "should allow a provider up to 255 characters" do 
    @authentication.provider = rand(36**255).to_s(36)
    @authentication.should be_valid
  end

  it "should not allow a provider over 255 characters" do 
    @authentication.provider = rand(36**256).to_s(36)
    @authentication.should_not be_valid
  end

  it "should allow a uid up to 255 characters" do 
    @authentication.uid = rand(36**255).to_s(36)
    @authentication.should be_valid
  end

  it "should not allow a uid over 255 characters" do 
    @authentication.uid = rand(36**256).to_s(36)
    @authentication.should_not be_valid
  end

  it "should allow a token up to 255 characters" do 
    @authentication.token = rand(36**255).to_s(36)
    @authentication.should be_valid
  end

  it "should not allow a token over 255 characters" do 
    @authentication.token = rand(36**256).to_s(36)
    @authentication.should_not be_valid
  end

  it "should allow a secret up to 255 characters" do 
    @authentication.token = rand(36**255).to_s(36)
    @authentication.should be_valid
  end

  it "should not allow a secret over 255 characters" do 
    @authentication.token = rand(36**256).to_s(36)
    @authentication.should_not be_valid
  end
  
end

