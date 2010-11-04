require 'spec_helper'

describe PagesController do

  describe '#index' do

    context 'when not logged in' do

      before(:each) do
        get :index
      end

      it 'shows the home page' do
        response.should be_success
      end

    end

    context 'when logged in' do

      before(:each) do 
        @user = Factory.create(:user)
        sign_in @user
        get :index
      end

      it 'redirect to the statuses page' do
        response.should redirect_to(statuses_path)
      end

    end

  end

  describe '#help' do

    context 'when not logged in' do

      it 'shows the help page' do
        get :help
        response.should be_success
      end

    end

  end

end


