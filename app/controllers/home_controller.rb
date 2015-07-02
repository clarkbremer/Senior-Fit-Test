class HomeController < ApplicationController
  def home_redirect
    if current_user.resident.is_admin?
      @administrator = current_user.resident
      render 'admin_home'
    elsif current_user.resident.is_assessor?
      @assessor = current_user.resident.assessor
      render 'assessor_home'
    else
      @resident = current_user.resident
      redirect_to resident_path(@resident), notice: "Welcome, #{@resident.first_name}."
    end
  end
end
