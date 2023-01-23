require 'rails_helper'

feature 'User can add reward to his question' do
  describe 'Authenticated user asks question', js: true do
    given(:user) { create(:user) }
    given(:reward_image) { "#{Rails.root}/spec/rails_helper.rb" }

    background do
      sign_in(user)
      visit root_path
      click_on 'Ask question'
      fill_in 'Title', with: 'Question title'
      fill_in 'Body', with: 'Text of the question'
    end

    scenario 'adds the reward' do
      fill_in 'Reward title', with: 'reward title'
      attach_file 'Image', reward_image
      click_on 'Ask'

      expect(page).to have_content 'Your question successfully created.'
    end
  end
end
