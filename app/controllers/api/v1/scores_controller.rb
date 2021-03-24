class Api::V1::ScoresController < ApplicationController
  def index
    scores = Score.where('level_id = ?', params[:level_id].to_i).order('milliseconds ASC')

    render json: scores
  end

  def create
    score = Score.new(score_params)

    if score.save
      render :nothing, status: :accepted
    else
      render json: { error: 'The score was not saved.' }, status: :bad_request
    end
  end

  private

  def score_params
    params.permit(:level_id, :name, :milliseconds)
  end
end
