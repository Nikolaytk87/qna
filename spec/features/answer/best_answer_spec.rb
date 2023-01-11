require 'rails_helper'

feature 'User can choose the best answer', "
  As an author of question
  I'd like to be able to choose the best answer
" do
  given!(:author) { create(:user) }
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: author) }
  given!(:answer) { create(:answer, user: author, question: question) }
  given!(:answers) { create_list(:answer, 3, user: author, question: question) }

  scenario 'Unauthenticate user can not choose the best answer', js: true do
    visit question_path(question)

    expect(page).to_not have_link 'Best answer'
  end

  describe 'Authenticate user', js: true do
    scenario 'can choose the best answer his question ' do
      sign_in(author)
      visit question_path(question)
      within "#answer_#{answers.first.id}" do
        click_on 'Best answer'

        expect(page).to have_content answers.first.body
      end
    end

    scenario "can not choose the best answer other user's question" do
      sign_in(user)
      visit question_path(question)
      within "#answer_#{answers.first.id}" do
        expect(page).to_not have_link 'Best answer'
      end
    end
  end
end
