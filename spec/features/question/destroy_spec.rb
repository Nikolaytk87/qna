require 'rails_helper'

feature 'Authenticate user can remove his question', "
  In order to remove the question
  I'd like to able to remove  the question
" do
  given(:user) { create(:user) }
  given(:author) { create(:user) }
  given!(:question) { create(:question, user: author) }

  scenario 'Authenticate user can remove his question', js: true do
    sign_in(author)
    visit question_path(question)
    accept_alert do
      click_on 'Remove Question'
    end
    expect(page).to have_content 'You have successfully remove question'
  end

  scenario "Authenticate user  remove other people's  question", js: true do
    sign_in(user)
    visit question_path(question)

    expect(page).to_not have_link 'Remove Question'
  end

  scenario 'Unauthenticate user  remove  question' do
    visit question_path(question)

    expect(page).to_not have_link 'Remove Question'
  end
end
