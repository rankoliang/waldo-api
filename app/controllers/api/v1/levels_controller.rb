class Api::V1::LevelsController < ApplicationController
  before_action :find_level, except: %i[index]

  def index
    @levels = Rails.cache.fetch('levels') do
      Level.includes(image_attachment: :blob).all.as_json
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
    @level = Rails.cache.fetch("levels/#{params[:id]}") do
      Level.includes(:search_areas,
                     characters: [avatar_attachment: :blob],
                     image_attachment: :blob)
           .find(params[:id])
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'The level was not found.' }, status: :not_found
  end
end
