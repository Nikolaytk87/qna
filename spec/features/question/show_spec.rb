require 'rails_helper'

feature 'User can see answers to the question', "
  In order to  see the answers to the question
  As an  user
  I'd like to able to see  the answers to question
" do
  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: user, question: question) }

  scenario 'Authenticate user can see the answers' do
    sign_in(user)
    check_answer_page_content
  end
  scenario 'Unauthenticate user can see the answers' do
    check_answer_page_content
  end

  def check_answer_page_content
    visit question_path(answer.question)

    expect(page).to have_content answer.question.title
    expect(page).to have_content answer.question.body
    expect(page).to have_content answer.body
  end
end
