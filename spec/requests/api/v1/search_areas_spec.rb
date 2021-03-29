require 'rails_helper'

RSpec.describe 'Api::V1::SearchAreas', type: :request do
  subject(:search_area) { FactoryBot.create('search_area') }
  let(:level) { search_area.level }

  xdescribe 'GET /levels/:level_id/search_areas/:id/search' do
    context 'when the level is found' do
      let(:start_time) { Time.new(2020, 1, 1, 12, 30, 0) }

      before :each do
        travel_to start_time do
          get api_v1_level_path(level)
        end
      end

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

        it 'sets the the character_found key to true' do
          get api_v1_level_search_path(level, search_area), params: { x: 5, y: 5 }

          jar = build_jar(request, cookies)

          characters_found = JSON.parse(jar.signed['characters_found'])

          expect(characters_found).to include(search_area.character_id.to_s => true)
        end

        context 'when it is the last character to be found' do
          it 'sets the end time cookie' do
            end_time = start_time + 2.minutes

            travel_to end_time do
              get api_v1_level_search_path(level, search_area), params: { x: 5, y: 5 }

              jar = build_jar(request, cookies)

              expect(jar.signed['end_time']).to eq(end_time)
            end
          end
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
