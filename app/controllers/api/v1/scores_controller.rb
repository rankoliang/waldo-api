class Api::V1::ScoresController < ApplicationController
  before_action :set_token, only: [:create]

  def index
    level = Level.includes(:scores).find(params[:level_id])
    scores = level.scores.paginate(page: params[:page] || 1, per_page: 20).order('milliseconds ASC')

    render json: { level: level, scores: scores, pages: (level.scores.count / 20) + 1 }
  end

  def create
    return render json: { error: 'No token found' }, status: :bad_request unless params[:token]

    score = Score.new(milliseconds: milliseconds_elapsed, **score_params)

    if score.save
      render json: { position: score.ranking }, status: :accepted
    else
      render json: { errors: score.errors }, status: :bad_request
    end
  end

  private

  def score_params
    params.permit(:level_id, :name)
  end

  def set_token
    @token = decrypt_and_verify(params[:token])
  end

  def start_time
    @token['start_time']
  end

  def end_time
    @token['end_time']
  end

  def milliseconds_elapsed
    ((end_time - start_time) * 1000).ceil
  end
end
