require 'rails_helper'

feature "Resident signing in" do
  let(:resident) { FactoryGirl.create(:resident_with_user) }

  scenario "Resident logs in with correct credentials" do
    visit '/users/sign_in'
    fill_in 'Email', :with => resident.user.email
    fill_in 'Password', :with => 'password'
    click_button 'Log in'
    expect(page).to have_content "Welcome, #{resident.first_name}"
    expect(page).to have_content "Resident: #{resident.first_name} #{resident.last_name}"
  end

  scenario "Resident logs in with incorrect credentials" do
    visit '/users/sign_in'
    fill_in 'Email', :with => resident.user.email
    fill_in 'Password', :with => 'bad_password'
    click_button 'Log in'
    expect(page).to have_content "Invalid email or password"
  end

end
