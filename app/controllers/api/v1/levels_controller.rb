class Api::V1::LevelsController < ApplicationController
  before_action :find_level, except: %i[index]

  def index
    @levels = Rails.cache.fetch('levels', expires_in: ActiveStorage.service_urls_expire_in) do
      Level.includes(image_attachment: :blob).all.as_json(thumbnail: true)
    end

    render json: @levels
  end

  def show
    characters_found = @level.characters.map { |character| [character.id, false] }.to_h

    token = encrypt_and_sign({ 'start_time' => Time.current, 'characters_found' => characters_found })

    render json: @level.as_json
                       .merge({ characters: @level.search_areas, token: token })
  end

  private

  def find_level
    @level = Level.cached(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'The level was not found.' }, status: :not_found
  end
end
