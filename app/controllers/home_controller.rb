class HomeController < ApplicationController
  def home_redirect
    case current_user.person_type
    when "Admin"
      @administrator = current_user.person
      render 'admin_home'
    when "Assessor"
      @assessor = current_user.person
      render 'assessor_home'
    when "Resident"
      @resident = current_user.person
      render 'resident_home'
    end
  end
end
