class LandingPageController < ApplicationController
  def landing_page
    case current_user.person_type
    when "Admin"
      redirect_to communities_path
    when "Assessor"
      redirect_to communities_path
    when "Resident"
      redirect_to resident_path(current_user.person)
    end
  end
end
