require 'spec_helper'

describe PagesController do

  describe '#help' do

    context 'when not logged in' do

      it 'shows the help page' do
        get :help
        response.should be_success
      end

    end

  end

end


