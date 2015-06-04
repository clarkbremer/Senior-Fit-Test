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

  def edit
    @resident = Resident.find(params[:id])
    authorize @resident
  end

  def update
    @resident = Resident.find(params[:id])
    authorize @resident
    if @resident.update_attributes(secure_params)
      redirect_to community_resident_path(@resident.community, @resident), :notice => "Resident updated."
    else
      render :edit
    end
  end

  def new
    @resident = Resident.new
  end

  def create
    @community = Community.find(params[:community_id])
    @resident = @community.create_resident(secure_params)
  end

  def destroy
    @resident = Resident.find(params[:id])
    authorize @resident
    @resident.destroy
    redirect_to residents_path, :notice => "Resident deleted."
  end

  private

  def secure_params
    params.require(:resident).permit(user_attributes: [:id, :name])
  end

end
