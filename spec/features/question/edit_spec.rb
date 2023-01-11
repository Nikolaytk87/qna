require 'rails_helper'

feature 'User can edit his question' do
  given(:user) { create(:user) }
  given(:author) { create(:user) }
  given(:question) { create(:question, user: author) }

  scenario "Unauthenticate user can't edit question" do
    visit question_path(question)

    expect(page).to_not have_content 'Edit'
  end

  describe 'Authenticate user', js: true do
    scenario 'Edit his question' do
      sign_in(author)
      visit question_path(question)
      within '.question' do
        click_on 'Edit question'
        fill_in 'Title',	with: 'sometext Title'
        fill_in 'Body',	with: 'sometext Body'
        click_on 'Ask'
      end
      expect(page).to have_content 'sometext Title'
      expect(page).to have_content 'sometext Body'
    end

    scenario 'Edit his question with errors' do
      sign_in(author)
      visit question_path(question)
      within '.question' do
        click_on 'Edit question'
        fill_in 'Title',	with: ''
        fill_in 'Body',	with: ''
        click_on 'Ask'
      end

      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "Body can't be blank"
    end

    scenario 'Edit someone question' do
      sign_in(user)
      visit question_path(question)

      expect(page).to_not have_content 'Edit question'
    end
  end
end
