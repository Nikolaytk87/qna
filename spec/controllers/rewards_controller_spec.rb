require 'rails_helper'

RSpec.describe RewardsController, type: :controller do
  let(:user) { create :user }
  let(:question) { create :question, user: user }
  let(:answer) { create :answer, question: question, user: user }
  let(:reward) { create :reward, user_id: user.id }

  describe 'GET #index' do
    context 'authenticated user' do
      before do
        login(user)
        get :index
      end

      it 'array of all awards' do
        expect(assigns(:rewards)).to match_array(user.rewards)
      end

      it 'renders index view' do
        expect(response).to render_template :index
      end
    end

    context 'unauthenticated user' do
      it 'redirects to sign in page' do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
