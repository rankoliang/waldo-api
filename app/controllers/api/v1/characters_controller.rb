class Api::V1::CharactersController < ApplicationController
  before_action :find_level
  before_action :find_character, except: :index

  def index; end

  def search; end

  private

  def find_level
    @level = Level.find(params[:level_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'The level was not found.' }, status: :not_found
  end

  def find_character
    @character = Character.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'The character was not found' }, status: :not_found
  end
end
