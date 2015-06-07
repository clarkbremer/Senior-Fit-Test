class AssessmentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @assments = policy_scope(Assessment)
    authorize Assessment
  end

  def show
    @assessment = Assessment.find(params[:id])
    authorize @assessment
  end

  def edit
    @assessment = Assessment.find(params[:id])
    authorize @assessment
  end

  def update
    @assessment = Assessment.find(params[:id])
    authorize @assessment
    if @assessment.update_attributes(secure_params)
      redirect_to resident_path(@assessment.resident), :notice => "Assessment updated."
    else
      render :edit
    end
  end

  def new
    @resident = Resident.find(params[:resident_id])
    @assessment = Assessment.new
    @assessment.date = Date.today
  end

  def create
    @resident = Resident.find(params[:resident_id])
    @assessment = @resident.assessments.build(secure_params)
    if @assessment.save
      redirect_to resident_path(@resident), :notice => "Assessment Added."
    else
      render :edit
    end
  end

  def destroy
    @assessment = Assessment.find(params[:id])
    resident = @assessment.resident
    authorize @assessment
    @assessment.destroy
    redirect_to resident_path(resident), :notice => "Assessment deleted."
  end

  private

  def secure_params
    params.require(:assessment).permit( :date,
                                        :chair_stand,
                                        :arm_curl,
                                        :two_minute_step,
                                        :sit_and_reach,
                                        :back_scratch,
                                        :eight_foot_up_and_go)
  end

end
