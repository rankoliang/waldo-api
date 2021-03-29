class Api::V1::SearchAreasController < ApplicationController
  def show
    search_area = SearchArea.find(params[:id])

    raise ActiveRecord::RecordNotFound unless search_area.level_id == params[:level_id].to_i

    raise ArgumentError if params[:x].nil? || params[:y].nil?

    found = search_area.found?(x: params[:x].to_i, y: params[:y].to_i)

    characters_found do |cf|
      cf[search_area.character_id.to_s] = true
      cookies.signed['end_time'] = Time.current if cf.values.all?(true)
    end

    render json: { found: found }
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'The character was not found' }, status: :not_found
  rescue ArgumentError
    render json: { error: 'Incorrect coordinate format' }, status: :bad_request
  end

  def characters_found
    cf = JSON.parse(cookies.signed['characters_found'])

    yield(cf)

    cookies.signed['characters_found'] = JSON.generate(cf)
  end
end
