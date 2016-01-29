class ResidentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @residents = policy_scope(Resident)
    authorize Resident
  end

  def show
    @resident = Resident.find(params[:id])
    authorize @resident
    @chart_data = @resident.assessment_chart_data
  end

  def edit
    @resident = Resident.find(params[:id])
    authorize @resident
#    if @resident.user.blank?
#      @resident.build_user
#    end
  end

  def update
    @resident = Resident.find(params[:id])
    authorize @resident
    if @resident.update_attributes(secure_params)
      redirect_to resident_path(@resident), notice: "Resident updated."
    else
      render :edit
    end
  end

  def new
    @community = Community.find(params[:community_id])
    @resident = Resident.new
    @resident.build_user
  end

  def create
    @community = Community.find(params[:community_id])
    @resident = @community.residents.build(secure_params)
    if @resident.save
      redirect_to resident_path(@resident), notice: "Resident Created."
    else
      render :new
    end
  end

  def destroy
    @resident = Resident.find(params[:id])
    authorize @resident
    @resident.destroy
    redirect_to community_path(@resident.community), notice: "Resident deleted."
  end

  def make_assessor
    @resident = Resident.find(params[:resident_id])
    if @resident.user
      @assessor = Assessor.new(resident: @resident)
      if @assessor.save
        redirect_to edit_assessor_path(@assessor), notice: "Resident is now an Assessor"
      else
        redirect_to resident_path(@resident), alert: "Was unable to create an Assessor"
      end
    else
      redirect_to resident_path(@resident), alert: "Resident must have login before becoming an Assessor"
    end
  end

  private

  def secure_params
    params.require(:resident).permit(:first_name, :last_name, :birthdate, :gender, :address1, :address2, :city, :state, :zip, :phone)
  end

end
