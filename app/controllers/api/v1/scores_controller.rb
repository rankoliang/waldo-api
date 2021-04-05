class Api::V1::ScoresController < ApplicationController
  before_action :set_token, only: [:create]

  def index
    level = Level.cached(params[:level_id])

    scores = level.scores.paginate(page: params[:page] || 1, per_page: 20).order('milliseconds ASC')

    render json: { level: level.as_json(thumbnail: true), scores: scores, pages: (level.scores.count / 20) + 1 }
  end

  def create
    return render json: { errors: { token: 'No token found' } }, status: :bad_request unless params[:token]

    if end_time - Time.current > 20.minutes
      return render json: { errors: 'Request timed out.' }, status: :request_timeout
    end

    if Rails.cache.read("token/#{params[:token]}")
      return render json: { errors: { token: 'Token has already been used! Game invalid.' } }, status: :bad_request
    end

    score = Score.new(milliseconds: milliseconds_elapsed, **score_params)

    if score.save
      Rails.cache.write("token/#{params[:token]}", true, expires_in: 20.minutes)
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
