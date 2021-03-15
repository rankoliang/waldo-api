class LevelsController < ApplicationController
  before_action :find_level, except: %i[index]
  def index
    @levels = Level.all

    render json: @levels
  end

  def show
    render json: @level.as_json(root: true)
  end

  def find_level
    @level = Level.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'The level was not found.' }, status: :not_found
  end
end
