
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
  
  describe PublishFrequencies do

    describe 'frequencies' do
      it 'should be equal to predefined list' do
        PublishFrequencies.frequencies.should == ['1 minute', '5 minutes', '10 minutes', '20 minutes', '30 minutes', '1 hour', '2 hours', '3 hours', '4 hours', '5 hours', '6 hours', '7 hours', '8 hours', '1 day', '2 days', '3 days', '4 days', '5 days', '6 days', '1 week', '2 weeks', '3 weeks', '1 month']
      end
    end
    
    describe '.time_from_str' do
      it 'input not in frequencies should output empty string' do
        PublishFrequencies.time_from_str('minute').should == ''
        PublishFrequencies.time_from_str('').should == ''
        PublishFrequencies.time_from_str('23').should == ''
        PublishFrequencies.time_from_str('asdf').should == ''
        
        PublishFrequencies.time_from_str('231 weeks').should == ''
        PublishFrequencies.time_from_str('83 minutes').should == ''
        PublishFrequencies.time_from_str('1 minutes').should == ''
        PublishFrequencies.time_from_str('1 hours').should == ''
        PublishFrequencies.time_from_str('5 week').should == ''
        PublishFrequencies.time_from_str('8 month').should == ''
      end
      
      it 'should output the right number' do
        PublishFrequencies.time_from_str('1 minute').should == '1'
        PublishFrequencies.time_from_str('3 hours').should == '3'
        PublishFrequencies.time_from_str('2 days').should == '2'
        PublishFrequencies.time_from_str('1 week').should == '1'
        PublishFrequencies.time_from_str('1 month').should == '1'
      end
    end
    
    describe '.time_unit_from_str' do
      it 'input not in frequencies should output empty string' do
        PublishFrequencies.time_unit_from_str('minute').should == ''
        PublishFrequencies.time_unit_from_str('').should == ''
        PublishFrequencies.time_unit_from_str('23').should == ''
        PublishFrequencies.time_unit_from_str('asdf').should == ''
        
        PublishFrequencies.time_unit_from_str('231 weeks').should == ''
        PublishFrequencies.time_unit_from_str('83 minutes').should == ''
        PublishFrequencies.time_unit_from_str('1 minutes').should == ''
        PublishFrequencies.time_unit_from_str('1 hours').should == ''
        PublishFrequencies.time_unit_from_str('5 week').should == ''
        PublishFrequencies.time_unit_from_str('8 month').should == ''
      end
      
      it 'singular names should be pluralised' do
        PublishFrequencies.time_unit_from_str('1 minute').should == 'minutes'
        PublishFrequencies.time_unit_from_str('1 hour').should == 'hours'
        PublishFrequencies.time_unit_from_str('1 day').should == 'days'
        PublishFrequencies.time_unit_from_str('1 week').should == 'weeks'
        PublishFrequencies.time_unit_from_str('1 month').should == 'months'
      end
      
      it 'pluralised names should be pluralised' do
        PublishFrequencies.time_unit_from_str('5 minutes').should == 'minutes'
        PublishFrequencies.time_unit_from_str('4 hours').should == 'hours'
        PublishFrequencies.time_unit_from_str('5 days').should == 'days'
        PublishFrequencies.time_unit_from_str('2 weeks').should == 'weeks'
      end
      
    end
    
    describe '.frequency_default_from_setting' do
      def frequency_time_and_unit_default_equals_output(frequency_time, frequency_unit, output)
        setting = Factory(:setting, :time_digit => frequency_time, :time_unit => frequency_unit)
        PublishFrequencies.frequency_default_from_setting(setting).should == output
      end
      
      it 'is 2 hours with no settings' do
        PublishFrequencies.frequency_default_from_setting(nil).should == '2 hours'
      end
      
      it 'is 2 hours with no time and time unit values in settings' do
        frequency_time_and_unit_default_equals_output(nil, nil, '2 hours')
      end
      
      describe 'is 2 hours if settings has the invalid value: ' do
        it "2 minutes (not in list)" do
          frequency_time_and_unit_default_equals_output(2, 'minutes', '2 hours')
        end
        
        it "15 hours" do
          frequency_time_and_unit_default_equals_output(15, 'hours', '2 hours')
        end
          
        it "15 hour" do
          frequency_time_and_unit_default_equals_output(15, 'hour', '2 hours')
        end
        
        it "12 months" do
          frequency_time_and_unit_default_equals_output(12, 'months', '2 hours')
        end
      end
      
      describe 'is the settings value with valid setting:' do
        it "5 minutes" do
          frequency_time_and_unit_default_equals_output(5, 'minutes', '5 minutes')
        end
        
        it "1 hour" do
          frequency_time_and_unit_default_equals_output(1, 'hours', '1 hour')
        end
        
        it "5 days" do
          frequency_time_and_unit_default_equals_output(5, 'days', '5 days')
        end
        
        it "1 week" do
          frequency_time_and_unit_default_equals_output(1, 'weeks', '1 week')
        end
        
        it "1 month" do
          frequency_time_and_unit_default_equals_output(1, 'months', '1 month')
        end
      end
    end

  end
end

