require 'rails_helper'

feature 'User can add links to question', "
  In order to provide additional info to my question
  As a question's author
  I'd like to be able to add links
  " do
    given(:user) { create(:user) }
    given(:author) { create(:user) }
    given(:url) { 'https://ya.ru' }
    given(:gist_url) { 'https://gist.github.com/Nikolaytk87/afae637965d5f9ac950fe5dc1901cd00' }

    background do
      sign_in(author)
      visit new_question_path
    end

    scenario 'Author adds link to Gist when asks question', js: true do
      fill_in 'Title', with: 'Text question'
      fill_in 'Body', with: 'Text body'

      fill_in 'Link name', with: 'My gist'
      fill_in 'Url', with: gist_url

      click_on 'Ask'
      within('.gist') do
        expect(page).to have_content 'What does CSS stand for?'
      end
    end

    scenario 'Author adds links when asks question', js: true do
      fill_in 'Title', with: 'Text question'
      fill_in 'Body', with: 'Text body'

      click_on 'add link'

      within all('.nested-fields').last do
        fill_in 'Link name', with: 'my-link'
        fill_in 'Url', with: url
      end
      click_on 'Ask'
      expect(page).to have_link 'my-link', href: url
    end
  end
