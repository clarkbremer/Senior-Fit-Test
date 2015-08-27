require 'rails_helper'

feature "Resident views home page" do
  before :all do
    @resident =  FactoryGirl.create(:resident_with_user)
  end

  before do
    login_as(@resident.user, :scope => :user)
  end

  context "Resident Has No Assessments" do
    it "Displays the Resident Header" do
      visit resident_path @resident
      expect(page).to have_content "Resident: #{@resident.first_name} #{@resident.last_name}"
    end

    it "Displays a page without assessments" do
      visit resident_path @resident
      expect(page).to_not have_content "Assessment Details:"
    end
  end

  context "Resident Has Assessment" do
    before :all do
      @assessment = FactoryGirl.create(:assessment, resident: @resident)
    end

    it "Displays the Resident Header" do
      visit resident_path @resident
      expect(page).to have_content "Resident: #{@resident.first_name} #{@resident.last_name}"
    end

    it "Displays a page with assessment" do
      visit resident_path @resident
      expect(page).to have_content "Assessment Details:"
      expect(page).to have_link "#{Date.today.to_s}"
    end

    it "Has a C3 chart", :js => true do
      visit resident_path @resident
      expect(page).to have_css('div#assessments_chart.c3')
    end
  end

end
