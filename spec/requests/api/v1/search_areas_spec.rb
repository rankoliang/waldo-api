require 'rails_helper'

RSpec.describe 'Api::V1::SearchAreas', type: :request do
  subject(:search_area) { FactoryBot.create('search_area') }
  let(:level) { search_area.level }

  describe 'GET /levels/:level_id/search_areas/:id/search' do
    context 'when the level is found' do
      context 'when the character is found' do
        it 'returns http success' do
          get api_v1_level_search_path(level, search_area), params: { x: 5, y: 5 }

          expect(response).to have_http_status(:success)
        end

        it 'returns whether the character is found' do
          get api_v1_level_search_path(level, search_area), params: { x: 5, y: 5 }

          data = JSON.parse(response.body, symbolize_names: true)

          expect(data).to include(:found)
        end

        context 'when incorrect parameters are passed' do
          it 'returns http bad request' do
            get api_v1_level_search_path(level, search_area)

            expect(response).to have_http_status(:bad_request)
          end
        end
      end

      context 'when the character is not found' do
        it 'returns http not found' do
          get api_v1_level_search_path(level, 'invalid_id')
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context 'when the level is not found' do
      context 'when the character is found' do
        it 'returns http not found' do
          get api_v1_level_search_path('invalid_id', search_area)
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'when the character is not found' do
        it 'returns http not found' do
          get api_v1_level_search_path('invalid_id', 'invalid_id')
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
