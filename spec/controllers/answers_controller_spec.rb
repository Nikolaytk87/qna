require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, user: user) }

  describe 'GET #new' do
    before { login(user) }
    before { get :new, params: { question_id: question } }

    it 'assign a new Answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before { login(user) }

    it '@answer.question equal question' do
      post :create, params: valid_answer_params
      expect(assigns(:answer).question).to eq question
    end

    context 'with valid attributes' do
      it 'saves a new answer in to database' do
        expect { post :create, params: valid_answer_params }.to change(question.answers, :count).by(1)
      end

      it 'redirect to show view' do
        post :create, params: valid_answer_params
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        post :create, params: invalid_answer_params
        expect { post :create, params: invalid_answer_params }.to_not change(question.answers, :count)
      end

      it 're renders new view' do
        post :create, params: invalid_answer_params
        expect(response).to render_template :new
      end
    end
  end

  def valid_answer_params
    { question_id: question, answer: attributes_for(:answer), user: user }
  end

  def invalid_answer_params
    { question_id: question, answer: attributes_for(:answer, :invalid), user: user }
  end

  describe 'DELETE #destroy' do
    before { login(user) }
    let!(:answer) { create(:answer, user: user, question: question) }

    it 'delete the answer' do
      expect { delete :destroy, params: { id: answer } }.to change(Answer, :count).by(-1)
    end

    it 'redirects to show question' do
      delete :destroy, params: { id: answer }
      expect(response).to redirect_to assigns(:answer).question
    end
  end
end
