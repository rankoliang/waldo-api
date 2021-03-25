require 'rails_helper'

RSpec.describe 'Api::V1::Characters', type: :request do
  subject(:character) { search_area.character }
  let(:search_area) { FactoryBot.create('search_area') }
  let(:level) { search_area.level }

  describe 'GET /levels/:level_id/characters' do
    context 'when the level is found' do
      before :each do
        get api_v1_level_characters_path(level)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns an array of search_areas' do
        search_areas = JSON.parse(response.body)

        expect(search_areas.length).to eq 1
      end

      it 'returns characters with a name attribute' do
        search_areas = JSON.parse(response.body, symbolize_names: true)

        expect(search_areas.first).to include(:search_area_id, :name, :id, :avatar_path)
      end
    end

    context 'when the level is not found' do
      it 'returns http not found' do
        get api_v1_level_characters_path('invalid_id')

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
