require 'rails_helper'

feature 'Authenticate user can remove his answer', "
  In order to remove answer to the question
  I'd like to able to remove  the answer to the question
" do
  given(:user) { create(:user) }
  given(:author) { create(:user) }
  given(:question) { create(:question, user: author) }
  given!(:answer) { create(:answer, user: author, question: question) }

  scenario 'Authenticate user can remove his answer', js: true do
    sign_in(author)
    visit question_path(question)
    accept_alert do
      click_on 'Remove Answer'
    end
    expect(page).to_not have_content answer.body
  end

  scenario "Authenticate user  remove other people's  answer" do
    sign_in(user)
    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_link 'Remove Answer'
    end
  end

  scenario 'Unauthenticate user  remove  answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Remove Answer'
  end
end
