
require 'spec_helper'

describe Setting do

  it { should belong_to(:user) }
  it { should validate_numericality_of(:user_id) }

  before(:each) do
    @setting = Factory(:setting)
  end

  it "is valid with valid attributes" do 
    @setting.should be_valid
  end

  
end

