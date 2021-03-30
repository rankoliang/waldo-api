class Api::V1::SearchAreasController < ApplicationController
  def show
    handle_errors do
      set_search_area

      check_valid_request

      return render json: { error: 'No token found' }, status: :bad_request unless params[:token]

      token = search_token_update

      render json: { found: found, token: token, duration: milliseconds_elapsed(token) }
    end
  end

  private

  def handle_errors
    yield
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'The character was not found' }, status: :not_found
  rescue ArgumentError
    render json: { error: 'Incorrect coordinate format' }, status: :bad_request
  end

  def set_search_area
    @search_area = Rails.cache.fetch("search_area/#{params[:id]}") do
      SearchArea.find(params[:id])
    end
  end

  def check_valid_request
    raise ActiveRecord::RecordNotFound unless @search_area.level_id == params[:level_id].to_i

    raise ArgumentError if params[:x].nil? || params[:y].nil?

    false
  end

  def found
    @search_area.found?(x: params[:x].to_i, y: params[:y].to_i)
  end

  def search_token_update
    update_token(params[:token]) do |data|
      characters_found = data['characters_found']
      characters_found[@search_area.character_id] = true
      data['end_time'] = Time.current if characters_found.values.all?(true)
    end
  end

  def milliseconds_elapsed(token)
    data = decrypt_and_verify(token)

    ((data['end_time'] - data['start_time']) * 1000).ceil if data['end_time']
  end
end
