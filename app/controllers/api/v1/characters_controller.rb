class Api::V1::CharactersController < ApplicationController
  def index
    level = Level.includes(:characters).find(params[:level_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'The level was not found.' }, status: :not_found
  end

  def search
    character = Character.find(params[:id])

    raise ActiveRecord::RecordNotFound unless character.level_id == params[:level_id].to_i
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'The character was not found' }, status: :not_found
  end
end
