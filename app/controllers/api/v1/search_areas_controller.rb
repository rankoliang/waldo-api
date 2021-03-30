class Api::V1::SearchAreasController < ApplicationController
  def show
    search_area = SearchArea.find(params[:id])

    raise ActiveRecord::RecordNotFound unless search_area.level_id == params[:level_id].to_i

    raise ArgumentError if params[:x].nil? || params[:y].nil?

    return render json: { error: 'No token found' }, status: :bad_request unless params[:token]

    found = search_area.found?(x: params[:x].to_i, y: params[:y].to_i)

    token = update_token(params[:token]) do |data|
      characters_found = data['characters_found']
      characters_found[search_area.character_id] = true
      data['end_time'] = Time.current if characters_found.values.all?(true)
    end

    render json: { found: found, token: token, duration: milliseconds_elapsed(token) }
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'The character was not found' }, status: :not_found
  rescue ArgumentError
    render json: { error: 'Incorrect coordinate format' }, status: :bad_request
  end

  private

  def milliseconds_elapsed(token)
    data = decrypt_and_verify(token)

    ((data['end_time'] - data['start_time']) * 1000).ceil if data['end_time']
  end
end
