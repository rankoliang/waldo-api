class Api::V1::LevelsController < ApplicationController
  before_action :find_level, except: %i[index]

  def index
    @levels = Level.includes(image_attachment: :blob).all

    render json: @levels
  end

  def show
    cookies.signed['start_time'] = Time.current
    p cookies.signed['start_time']

    render json: @level.as_json(root: true)
  end

  private

  def find_level
    @level = Level.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'The level was not found.' }, status: :not_found
  end
end
