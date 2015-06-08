class LoginsController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @resident = Resident.find(params[:resident_id])
    @login = @resident.user
  end

  def update
    @resident = Resident.find(params[:resident_id])
    if params[:user][:email].blank?
      @resident.user.destroy if @resident.user
      redirect_to resident_path(@resident), :notice => "Login removed."
    else
      @login = @resident.user
      if @login.update_attributes(secure_params)
        redirect_to resident_path(@resident), :notice => "Login updated."
      else
        render :edit
      end
    end
  end


  def new
    @resident = Resident.find(params[:resident_id])
    @login = User.new
  end

  def create
    @resident = Resident.find(params[:resident_id])
    @login = @resident.build_user(secure_params)
    if @login.save
      redirect_to resident_path(@resident), :notice => "Login Added."
    else
      render :edit
    end
  end

  private

  def secure_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
