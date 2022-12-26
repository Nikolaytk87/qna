require 'rails_helper'

feature 'User can create answer', "
  In order to answer to questions
  I'd like to be able to create answer for current question
" do
  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'creates answer with valid params' do
      fill_in 'answer_body', with: 'Answer to Question'
      click_on 'Answer'

      expect(page).to have_content 'You have successfully created the answer'
    end

    scenario 'creates answer with invalid params' do
      fill_in 'answer_body', with: ''
      click_on 'Answer'

      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario 'Unauthenticated user tries to create Answer', js: true do
    visit question_path(question)

    expect(page).to_not have_content 'New Answer'
  end
end
