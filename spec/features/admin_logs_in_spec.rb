require 'rails_helper'

feature "Signing in" do
  background do
    FactoryGirl.create(:user)
  end

  scenario "Signing in with correct credentials" do
    visit '/users/sign_in'
    fill_in 'Email', :with => 'user@example.com'
    fill_in 'Password', :with => 'password'
    click_button 'Log in'
    expect(page).to have_content 'Welcome'
  end

  # given(:other_user) { User.make(:email => 'other@example.com', :password => 'rous') }

  # scenario "Signing in as another user" do
  #   visit '/sessions/new'
  #   within("#session") do
  #     fill_in 'Email', :with => other_user.email
  #     fill_in 'Password', :with => other_user.password
  #   end
  #   click_button 'Sign in'
  #   expect(page).to have_content 'Invalid email or password'
  # end
end
