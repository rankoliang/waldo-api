class Api::V1::ScoresController < ApplicationController
  def index
    scores = Score.where('level_id = ?', params[:level_id].to_i)

    render json: scores
  end
end
