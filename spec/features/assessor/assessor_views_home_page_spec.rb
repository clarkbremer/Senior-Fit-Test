require 'rails_helper'

feature "Assessor views home page" do
  before :all do
    @assessor =  FactoryGirl.create(:assessor)
    @resident = @assessor.resident
  end

  before do
    login_as(@resident.user, :scope => :user)
  end

  context "Assessor Has No communities" do
    it "Displays the Assessor Header" do
      visit root_path
      expect(page).to have_content "Welcome, #{@resident.first_name}"
    end

    it "Displays a page without communities" do
      visit root_path
      expect(page).to_not have_content "You are an assessor for these communities"
      expect(page).to have_content "You are an assessor, but you have no communities"
    end
  end

  context "Assessor Has communities" do
    before :all do
      @community = FactoryGirl.create(:community)
      @community.assessors << @assessor
    end

    it "Displays a page with communities" do
      visit root_path
      expect(page).to have_content "You are an assessor for these communities:"
      expect(page).to have_link "#{@community.name}"
    end

    it "Has a link to the community" do
      visit root_path
      expect(page).to have_link "#{@community.name}"
      click_link "#{@community.name}"
      expect(page).to have_content "#{@community.city}"
    end

  end

end
