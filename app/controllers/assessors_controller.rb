class AssessorsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @assessors = policy_scope(Assessor)
    authorize Assessor
  end

  def show
    @assessor = Assessor.find(params[:id])
    authorize @assessor
  end

  def new
    @communities = Community.all
    @assessor = Assessor.new
  end

  def create
    @assessor = Assessor.new(secure_params)
    authorize @assessor
    if @assessor.save
      redirect_to assessors_path, :notice => "Assessor Added."
    else
      render :edit
    end
  end

  def edit
    @communities = Community.all
    @assessor = Assessor.find(params[:id])
    authorize @assessor
  end

  def update
    @assessor = Assessor.find(params[:id])
    authorize @assessor
    if @assessor.update_attributes(secure_params)
      redirect_to assessor_path, :notice => "Assessor updated."
    else
      redirect_to assessors_path, :alert => "Unable to update assessor."
    end
  end

  def destroy
    @assessor = Assessor.find(params[:id])
    authorize @assessor
    @assessor.destroy
    redirect_to assessors_path, :notice => "Assessor deleted."
  end

  private

  def secure_params
    params[:assessor][:community_ids] ||= []
    params.require(:assessor).permit(:name, community_ids: [])
  end

end
