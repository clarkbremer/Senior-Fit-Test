class NormsController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized, :except => :index

  def index
    @norms = Norm.all
  end

  def show
    @norm = Norm.find(params[:id])
    authorize @norm
    @percentiles = {}
    percentile = 95
    @norm.scores.each do |score|
      @percentiles[percentile] = score
      percentile -= 5
    end
  end

  def edit
    @norm = Norm.find(params[:id])
    authorize @norm
  end

  def update
    @norm = Norm.find(params[:id])
    authorize @norm
    if @norm.update_attributes(secure_params)
      if params[:save_and_edit_next].present?
        next_id = @norm.id + 1
        redirect_to edit_norm_path(next_id), :notice => "Percentile Norm updated."
      else
        redirect_to norms_path, :notice => "Percentile Norm updated."
      end
    else
      render :edit
    end
  end

  private

  def secure_params
    params.require(:norm).permit(scores: [])
  end

end
