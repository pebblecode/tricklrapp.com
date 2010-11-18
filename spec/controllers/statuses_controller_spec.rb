describe StatusesController do

  describe '#new' do

    context 'when not logged in' do

      before(:each) do
        get :new
      end

      it 'redirects to the sign in page' do
        response.should redirect_to(new_user_session_path)
      end

    end

  end

  describe '#index' do

    context 'when not logged in' do

      before(:each) do
        get :index
      end

      it 'redirects to the sign in page' do
        response.should redirect_to(pages_path)
      end

    end

    context 'when logged in' do

      before(:each) do 
        @user = Factory.create(:user)
        sign_in @user
        get :index
      end

      it 'shows the statuses page' do
        response.should be_success
      end

      it 'renders the index template' do
        response.should render_template("index")
      end

    end
  
  end

end
