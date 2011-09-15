
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

end
