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

  it "has all the assessment scores" do
    visit assessment_path @assessment
    expect(page).to have_content "Chair stand"
    expect(page).to have_content "Arm curl"
    expect(page).to have_content "Two minute step"
    expect(page).to have_content "Sit and reach"
    expect(page).to have_content "Back scratch"
    expect(page).to have_content "Eight foot up and go"
  end

  it "has the correct assessor" do
    visit assessment_path @assessment
    expect(page).to have_content "Assessment performed by #{@assessment.assessor.resident.first_name} #{@assessment.assessor.resident.last_name}"
  end

end
