require 'spec_helper'

describe Tweet do

  it { should validate_presence_of   :status }
  before(:all) do
    # This is run once and only once, before all of the examples
    # and before any before(:each) blocks.
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
    # this is run once and only once after all of the examples
    # and after any after(:each) blocks
  end
  
end

