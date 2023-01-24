require 'rails_helper'

feature 'User can add links to answer', "
  In order to provide additional info to my answer
  As a question's author
  I'd like to be able to add links
  " do
    given(:user) { create(:user) }
    given(:author) { create(:user) }
    given(:question) { create(:question, user: author) }
    given(:url) { 'https://ya.ru' }

    describe 'Author' do
      background do
        sign_in(author)
        visit question_path(question)
      end

      scenario 'adds link when asks answer', js: true do
        fill_in 'Your answer', with: 'Answer text'
        fill_in 'Link name', with: 'my-link'
        fill_in 'Url', with: url

        click_on 'Answer'

        within '.answers' do
          expect(page).to have_link 'my-link', href: url
        end
      end

      scenario 'adds links when asks answer', js: true do
        fill_in 'Your answer', with: 'Answer text'

        click_on 'add link'

        within all('.nested-fields').last do
          fill_in 'Link name', with: 'my-link'
          fill_in 'Url', with: url
        end
        click_on 'Answer'

        expect(page).to have_link 'my-link', href: url
      end
    end

    scenario 'Authenticated User tries to add link to another answer' do
      sign_in(user)
      visit question_path(question)

      expect(page).to_not have_link 'Answer'
    end

    scenario 'Unauthenticated user tries to add link' do
      visit question_path(question)

      expect(page).to_not have_link 'Answer'
    end
  end
