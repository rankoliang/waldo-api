class Api::V1::ScoresController < ApplicationController
  def index
    level = Level.includes(:scores).find(params[:level_id])
    scores = level.scores.order('milliseconds ASC')

    render json: { level: level, scores: scores }
  end

  def create
    score = Score.new(score_params)

    if score.save
      render :nothing, status: :accepted
    else
      render json: { errors: score.errors }, status: :bad_request
    end
  end

  private

  def score_params
    params.permit(:level_id, :name, :milliseconds)
  end
end
