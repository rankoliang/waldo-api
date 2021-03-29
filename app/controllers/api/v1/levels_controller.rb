class Api::V1::LevelsController < ApplicationController
  before_action :find_level, except: %i[index]

  def index
    @levels = Level.includes(image_attachment: :blob).all

    render json: @levels
  end

  def show
    cookies.signed['start_time'] = Time.current

    characters_found = @level.characters.map { |character| [character.id, false] }.to_h

    cookies.signed['characters_found'] = JSON.generate(characters_found)

    render json: @level.as_json(methods: %i[image_path])
                       .merge({ characters: @level.search_areas })
  end

  private

  def find_level
    @level = Level.includes(:search_areas, :characters).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'The level was not found.' }, status: :not_found
  end
end
