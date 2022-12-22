require 'rails_helper'

feature 'User can log out', "
  In order to exit from application
  I'd like to be able to log out
" do
  given!(:user) { create(:user) }

  background { visit root_path }

  scenario 'User tries to log out' do
    sign_in(user)
    click_on 'Log out'

    expect(page).to have_content 'Signed out successfully.'
  end

  scenario 'Guest tries to log out' do
    expect(page).to_not have_content 'Log out'
  end
end
