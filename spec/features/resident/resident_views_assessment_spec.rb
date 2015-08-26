require 'rails_helper'

feature "Resident views assessment" do
  before :all do
    @resident =  FactoryGirl.create(:resident_with_user)
    @assessment = FactoryGirl.create(:assessment, resident: @resident)
  end

  it "Displays a page with an assessment" do
    login_as(@resident.user, :scope => :user)
    visit resident_path @resident
    expect(page).to have_content "Resident: #{@resident.first_name} #{@resident.last_name}"
    expect(page).to have_content "Assessment Details:"
    expect(page).to have_link "#{Date.today.to_s}"
  end

  it "Has a C3 chart", :js => true do
    login_as(@resident.user, :scope => :user)
    visit resident_path @resident
    expect(page).to have_css('div#assessments_chart.c3')
  end
end
