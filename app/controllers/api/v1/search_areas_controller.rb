class Api::V1::SearchAreasController < ApplicationController
  def show
    character = SearchArea.find(params[:id])

    raise ActiveRecord::RecordNotFound unless character.level_id == params[:level_id].to_i

    raise ArgumentError if params[:x].nil? || params[:y].nil?

    render json: { found: character.found?(x: params[:x].to_i, y: params[:y].to_i) }
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'The character was not found' }, status: :not_found
  rescue ArgumentError
    render json: { error: 'Incorrect coordinate format' }, status: :bad_request
  end
end
