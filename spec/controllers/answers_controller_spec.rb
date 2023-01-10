require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user) }

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
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, params: invalid_answer_params }.to_not change(question.answers, :count)
      end

      it 're renders new view' do
        post :create, params: invalid_answer_params
        expect(response).to render_template :create
      end
    end
  end

  def valid_answer_params
    { question_id: question, answer: attributes_for(:answer), user: user, format: :js }
  end

  def invalid_answer_params
    { question_id: question, answer: attributes_for(:answer, :invalid), user: user, format: :js }
  end

  describe 'PATCH #best' do
    context 'Author of the question' do
      before do
        login(user)
        patch :best, params: { id: answer }, format: :js
      end
      let!(:answer) { create(:answer, user: user, question: question) }
      it 'choose the best answer' do
        answer.reload

        expect(answer).to be_best
      end

      it 'render best template' do
        expect(response).to render_template :best
      end
    end

    context 'Unauthenticated user' do
      it 'tries do mark as best answer' do
        answer.best = false
        patch :best, params: { id: answer, answer: { best: true } }, format: :js
        answer.reload
        expect(answer.best).to eq false
      end
    end
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

  describe 'PATCH #update' do
    before { login(user) }
    context 'with valid attributes' do
      it 'changes answer attributes' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
        answer.reload

        expect(answer.body).to eq 'new body'
      end
      it 'renders ajax view' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
        expect(response).to render_template :update
      end
    end
    context 'with invalid attributes' do
      it 'does not cahnge answer attributes' do
        expect do
          patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
        end.to_not change(answer, :body)
      end
      it 'renders ajax view' do
        patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
        expect(response).to render_template :update
      end
    end
  end
end
