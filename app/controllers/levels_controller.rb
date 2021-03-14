class LevelsController < ApplicationController
  before_action :find_level, except: %i[index]
  def index
    @levels = Level.all

    render json: @levels
  end

  def show
    render json: @level
  end

  def find_level
    @level = Level.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render nothing: true, status: :not_found
  end
end
