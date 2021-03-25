class Api::V1::ScoresController < ApplicationController
  def index
    level = Level.includes(:scores).find(params[:level_id])
    scores = level.scores.paginate(page: params[:page] || 1, per_page: 20).order('milliseconds ASC')

    render json: { level: level, scores: scores, pages: (Score.count / 20) + 1 }
  end

  def create
    score = Score.new(score_params)

    if score.save
      render json: { position: score.ranking }, status: :accepted
    else
      render json: { errors: score.errors }, status: :bad_request
    end
  end

  private

  def score_params
    params.permit(:level_id, :name, :milliseconds)
  end
end
