require 'rails_helper'

feature 'User can edit his answer', "
  In order to correct mistakes
  As an author of answer
  I'd like to be able to edit my answer
  " do
    given!(:author) { create(:user) }
    given!(:user) { create(:user) }
    given!(:question) { create(:question, user: author) }
    given!(:answer) { create(:answer, question: question, user: author) }

    scenario 'Unauthenticate user can not edit answer' do
      visit question_path(question)

      expect(page).to_not have_link 'Edit'
    end

    describe 'Authenticate user', js: true do
      background do
        sign_in(author)
        visit question_path(question)
      end

      scenario 'edits his answer' do
        click_on 'Edit'

        within '.answers' do
          fill_in 'Your answer', with: 'edited answer'
          click_on 'Save'

          expect(page).to_not have_content answer.body
          expect(page).to have_content 'edited answer'
          expect(page).to_not have_selector 'textarea'
        end
      end

      scenario 'edits an answer with an attached file' do
        within '.answers' do
          click_on 'Edit'

          fill_in 'Your answer', with: 'body body body'
          attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]

          click_on 'Save'
        end
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end

      scenario 'delete attached file', js: true do
        visit question_path(question)
        within '.answers' do
          click_on 'Edit'
          attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb"]
          click_on 'Save'

          click_on 'Delete file'

          expect(page).to_not have_content 'rails_helper.rb'
        end
      end

      scenario 'edits his answer with errors' do
        within '.answers' do
          click_on 'Edit'
          fill_in 'Your answer',	with: ''
          click_on 'Save'
        end

        expect(page).to have_content "Body can't be blank"
      end
    end

    scenario "tries to edit other user's question" do
      sign_in(user)
      visit question_path(question)

      expect(page).to_not have_content 'Edit'
    end
  end
