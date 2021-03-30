class Api::V1::LevelsController < ApplicationController
  before_action :find_level, except: %i[index]

  def index
    @levels = Level.includes(image_attachment: :blob).all

    render json: @levels
  end

  def show
    characters_found = @level.characters.map { |character| [character.id, false] }.to_h

    token = encrypt_and_sign({ 'start_time' => Time.current, 'characters_found' => characters_found })

    render json: @level.as_json(methods: %i[image_path])
                       .merge({ characters: @level.search_areas, token: token })
  end

  private

  def find_level
    @level = Level.includes(:search_areas, characters: [avatar_attachment: :blob])
                  .find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'The level was not found.' }, status: :not_found
  end
end
