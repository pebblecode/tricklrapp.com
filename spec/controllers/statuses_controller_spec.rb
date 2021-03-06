require 'spec_helper'

describe StatusesController do

  describe 'GET #index' do

    context 'when not logged in' do

      before(:each) do
        get :index
      end

      it 'redirects to the sign in page' do
        response.should redirect_to(new_user_session_path)
      end

    end

    context 'when logged in' do

      before(:each) do 
        @user = FactoryGirl.create(:user)
        sign_in @user
        get :index
      end

      it 'shows the tweets page' do
        response.should be_success
      end

      it 'renders the index template' do
        response.should render_template("index")
      end

    end
  
  end

  describe 'POST #create' do

    let(:status) { mock_model(Status).as_null_object }    

    context 'when not logged in' do

      before(:each) do
        post :create
      end

      it 'redirects to the sign in page' do
        response.should redirect_to(new_user_session_path)
      end

    end

    context 'when logged in' do

      before(:each) do 
        ResqueSpec.reset!
        @user = FactoryGirl.create(:user)
        sign_in @user
        Status.stub(:new).and_return(status)
      end

      it 'creates a new tweet' do
        Status.should_receive(:new).
          with("status" => "Foo bar").
          and_return(status)
        post :create, :status => { "status" => "Foo bar" }
      end

      context "when the tweet saves successfully" do

        before do
          status.stub(:save).and_return(true) 
        end

        it "sets a flash message" do
          post :create 
          flash[:notice].should eq("Hurray! Your tweet was scheduled for delivery")
        end

        it "redirects to the statuses url" do 
          post :create 
          response.should redirect_to(statuses_url)
        end

      end

      context "when the status fails to save" do 

        before do
          status.stub(:save).and_return(false) 
        end

        it "assigns @status" do
          post :create 
          assigns[:status].should eq(status)
        end

        it "redirects to the tweets url" do
          post :create 
          response.should render_template('index')
        end

      end

    end
  
  end
  describe 'PUT #publish' do
    let(:status) { mock_model(Status).as_null_object}

    context 'when not logged in' do

      before(:each) do
        ResqueSpec.reset!
        @user = FactoryGirl.create(:user)
        @status = FactoryGirl.create(:status, :user => @user)
      end
      it 'redirects to the sign in page' do
        put :publish, :id => @status.id
        response.should redirect_to(new_user_session_path)
      end
    end
    context 'when logged in' do
      before(:each) do 
        ResqueSpec.reset!
        @user = FactoryGirl.create(:user)
        sign_in @user
        @status = FactoryGirl.create(:status, :user => @user)
      end
      it 'reschedules the status' do
        put :publish, :id => @status.id
      end
      it "sets a flash message" do
        put :publish, :id => @status.id
        flash[:notice].should eq("Cool, your tweet has been rescheduled")
      end

      it "redirects to the statuses url" do 
        put :publish, :id => @status.id
        response.should redirect_to(statuses_url)
      end
    end
    
  end
end
