require 'spec_helper'

describe Status do

  it { should validate_presence_of(:status) }

  before(:all) do

  end

  before(:each) do
    # This is run before each example.
  end

  before do
    # :each is the default, so this is the same as before(:each)
  end

  it "should do stuff" do

  end

  it "should do more stuff" do

  end

  after(:each) do
    # this is after each example
  end
  
  after do
    # :each is the default, so this is the same as after(:each)
  end

  after(:all) do
  end
  
end

