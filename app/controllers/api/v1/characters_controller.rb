class Api::V1::CharactersController < ApplicationController
  def index
    level = Level.includes(:characters).find(params[:level_id])

    render json: level.characters
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'The level was not found.' }, status: :not_found
  end

  def search
    character = Character.find(params[:id])

    raise ActiveRecord::RecordNotFound unless character.level_id == params[:level_id].to_i

    render json: { found: character.found?(**coordinate_params) }
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'The character was not found' }, status: :not_found
  rescue ArgumentError
    render json: { error: 'missing coordinate' }, status: :bad_request
  end

  private

  def coordinate_params
    params.permit(:x, :y).to_h.symbolize_keys.transform_values(&:to_i)
  end
end
