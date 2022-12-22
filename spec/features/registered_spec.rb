require 'rails_helper'

feature 'User can register', "
  In order to use application
  With full functionality
  I'd like to be able to register
" do
  background do
    visit new_user_registration_path
  end

  scenario 'User tries to register with valid params' do
    fill_in 'Email', with: attributes_for(:user)[:email]
    fill_in 'Password', with: attributes_for(:user)[:password]
    fill_in 'Password confirmation', with: attributes_for(:user)[:password]
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
  scenario 'User tries to register with invalid params' do
    fill_in 'Email', with: attributes_for(:user)[:email]
    fill_in 'Password', with: ''
    fill_in 'Password confirmation', with: attributes_for(:user)[:password]
    click_on 'Sign up'

    expect(page).to have_content 'errors prohibited this user from being saved'
  end
end
