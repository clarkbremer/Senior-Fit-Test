require 'rails_helper'

feature "Assessor views community" do
  before :all do
    @assessor =  FactoryGirl.create(:assessor_with_community)
    @resident = @assessor.resident
    @community = @assessor.communities.first
  end

  before do
    login_as(@resident.user, :scope => :user)
  end

  it "Displays a page with communities" do
    visit assessor_path @assessor
    expect(page).to have_content "#{@resident.first_name} #{@resident.last_name} is an assessor for the following communities:"
  end

  it "has a link to the community" do
    visit assessor_path @assessor
    expect(page).to have_link "#{@community.name}"
    click_link "#{@community.name}"
    expect(page).to have_content "#{@community.name}"
    expect(page).to have_content "#{@community.city}"
    expect(page).to have_content "#{@community.state}"
  end

end
