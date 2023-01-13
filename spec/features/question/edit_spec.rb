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
    background do
      sign_in(author)
      visit question_path(question)
    end

    scenario 'Edit his question' do
      within '.question' do
        click_on 'Edit question'
        fill_in 'Title',	with: 'sometext Title'
        fill_in 'Body',	with: 'sometext Body'
        click_on 'Save'
      end
      expect(page).to have_content 'sometext Title'
      expect(page).to have_content 'sometext Body'
    end

    scenario 'edits a question with an attached file' do
      within '.question' do
        click_on 'Edit question'

        fill_in 'Title', with: 'title title'
        fill_in 'Body', with: 'body body body'
        attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]

        click_on 'Save'
      end
      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end

    scenario 'delete attached file', js: true do
      visit question_path(question)
      within '.question' do
        click_on 'Edit question'
        attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb"]
        click_on 'Save'

        click_on 'Delete file'

        expect(page).to_not have_content 'rails_helper.rb'
      end
    end
    scenario 'Edit his question with errors' do
      within '.question' do
        click_on 'Edit question'
        fill_in 'Title',	with: ''
        fill_in 'Body',	with: ''
        click_on 'Save'
      end

      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario 'Auth user Edit someone question' do
    sign_in(user)
    visit question_path(question)

    expect(page).to_not have_content 'Edit question'
  end
end
