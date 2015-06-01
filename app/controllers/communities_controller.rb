class CommunitiesController < ApplicationController

  def index
    @communities = policy_scope(Community)
    authorize Community
  end

  def show
    @community = Community.find(params[:id])
    authorize @community
  end

  def edit
    @community = Community.find(params[:id])
    authorize @community
  end

  def update
    @community = Community.find(params[:id])
    authorize @community
    if @community.update_attributes(secure_params)
      redirect_to communities_path, :notice => "Community updated."
    else
      redirect_to communities_path, :alert => "Unable to update community."
    end
  end

  def new
    @community = Community.new
  end

  def create
    @community = Community.new(secure_params)
    if @community.save
      redirect_to communities_path, notice: "Community Created."
    else
      redirect_to edit_path(@community), alert: "Unable to create community."
    end
  end

  def destroy
    @community = Community.find(params[:id])
    authorize @community
    @community.destroy
    redirect_to communities_path, :notice => "Community deleted."
  end

  private

  def secure_params
    params.require(:community).permit(:name, :city)
  end

end
