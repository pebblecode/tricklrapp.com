require 'spec_helper'

describe Authentication do

  before(:each) do
    @authentication = FactoryGirl.create(:authentication)
  end

  it "is valid with valid attributes" do 
    @authentication.should be_valid
  end

  it "should allow a provider up to 255 characters" do 
    @authentication.provider = Random.alphanumeric(255)
    @authentication.should be_valid
  end

  it "should not allow a provider over 255 characters" do 
    @authentication.provider = Random.alphanumeric(256)
    @authentication.should_not be_valid
  end

  it "should allow a uid up to 255 characters" do 
    @authentication.uid = Random.alphanumeric(255)
    @authentication.should be_valid
  end

  it "should not allow a uid over 255 characters" do 
    @authentication.uid = Random.alphanumeric(256)
    @authentication.should_not be_valid
  end

  it "should allow a token up to 255 characters" do 
    @authentication.token = Random.alphanumeric(255)
    @authentication.should be_valid
  end

  it "should not allow a token over 255 characters" do 
    @authentication.token = Random.alphanumeric(256)
    @authentication.should_not be_valid
  end

  it "should allow a secret up to 255 characters" do 
    @authentication.token = Random.alphanumeric(255)
    @authentication.should be_valid
  end

  it "should not allow a secret over 255 characters" do 
    @authentication.token = Random.alphanumeric(256)
    @authentication.should_not be_valid
  end
  
end

