require 'rails_helper'

feature "Resident views assessment" do
  before :all do
    @resident =  FactoryGirl.create(:resident_with_user)
    @assessment = FactoryGirl.create(:assessment, resident: @resident)
  end

  before do
    login_as(@resident.user, :scope => :user)
  end

  it "has a link to assessment details" do
    visit resident_path @resident
    expect(page).to have_content "Assessment Details:"
    expect(page).to have_link "#{Date.today.to_s}"
  end

  it "Shows the details page" do
    visit resident_path @resident
    click_link  "#{Date.today.to_s}"
    expect(page).to have_content "Assessment for #{@resident.first_name} #{@resident.last_name}"
    expect(page).to have_content "Assessment Date: #{Date.today.to_s}"
  end

end
