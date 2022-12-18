require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #new' do
    before { get :new, params: { question_id: question } }

    it 'assign a new Answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    it '@question.answer equal question' do
      post :create, params: valid_answer_params
      expect(assigns(:answer).question).to eq question
    end

    context 'with valid attributes' do
      it 'saves a new answer in to database' do
        expect { post :create, params: valid_answer_params }.to change(question.answers, :count).by(1)
      end

      it 'redirect to show view' do
        post :create, params: valid_answer_params
        expect(response).to redirect_to assigns(:answer)
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
    { question_id: question, answer: attributes_for(:answer) }
  end

  def invalid_answer_params
    { question_id: question, answer: attributes_for(:answer, :invalid) }
  end
end
