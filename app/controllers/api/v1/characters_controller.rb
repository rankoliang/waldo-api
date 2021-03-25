class Api::V1::CharactersController < ApplicationController
  def index
    level = Level.includes(:search_areas, characters: [avatar_attachment: :blob])
                 .find(params[:level_id])

    render json: level.search_areas
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'The level was not found.' }, status: :not_found
  end
end
