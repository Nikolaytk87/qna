require 'rails_helper'

feature 'User can view all questions', "
  In order view to be able to read questions
  As an any user
  I want to be able view questions
" do
  given(:user) { create(:user) }
  given!(:questions) { create_list(:question, 3, user: user) }

  scenario 'Any user can view questions' do
    visit questions_path
    questions.each do |question|
      expect(page).to have_content(question.title)
    end
  end
end
