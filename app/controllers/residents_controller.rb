class ResidentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @residents = policy_scope(Resident)
    authorize Resident
  end

  def show
    @resident = Resident.find(params[:id])
    authorize @resident
  end

  def update
    @resident = Resident.find(params[:id])
    authorize @resident
    if @resident.update_attributes(secure_params)
      redirect_to residents_path, :notice => "Resident updated."
    else
      redirect_to residents_path, :alert => "Unable to update resident."
    end
  end

  def destroy
    @resident = Resident.find(params[:id])
    authorize @resident
    @resident.destroy
    redirect_to residents_path, :notice => "Resident deleted."
  end

  private

  def secure_params
    params.require(:resident).permit(:name)
  end

end
