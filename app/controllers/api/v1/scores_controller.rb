class Api::V1::ScoresController < ApplicationController
  def index
    scores = Score.where('level_id = ?', params[:level_id].to_i)

    render json: scores
  end

  def create
    score = Score.new(level_id: params[:level_id], **score_params)

    if score.save
      render :nothing, status: :accepted
    else
      render json: { error: 'The score was not saved.' }, status: :bad_request
    end
  end

  private

  def score_params
    params.require(:score).permit(:name, :milliseconds)
  end
end
