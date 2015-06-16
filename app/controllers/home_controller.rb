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
      redirect_to resident_path(@resident), notice: "Welcome, #{@resident.first_name}."
    end
  end
end
