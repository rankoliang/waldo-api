require 'rails_helper'

RSpec.describe 'Api::V1::Characters', type: :request do
  subject(:character) { FactoryBot.create('character') }
  let(:level) { character.level }

  describe 'GET /levels/:level_id/characters' do
    context 'when the level is found' do
      before :each do
        get api_v1_level_characters_path(level)
      end
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns an array of characters' do
        characters = JSON.parse(response.body)

        expect(characters.length).to eq 1
      end

      it 'returns characters with a name attribute' do
        characters = JSON.parse(response.body, symbolize_names: true)

        expect(characters.first).to include(:id, :name)
      end
    end

    context 'when the level is not found' do
      it 'returns http not found' do
        get api_v1_level_characters_path('invalid_id')

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET /levels/:level_id/characters/:id/search' do
    context 'when the level is found' do
      context 'when the character is found' do
        it 'returns http success' do
          get api_v1_level_search_path(level, character), params: { x: 5, y: 5 }

          expect(response).to have_http_status(:success)
        end

        it 'returns whether the character is found' do
          get api_v1_level_search_path(level, character), params: { x: 5, y: 5 }

          data = JSON.parse(response.body, symbolize_names: true)

          expect(data).to include(:found)
        end

        context 'when incorrect parameters are passed' do
          it 'returns http bad request' do
            get api_v1_level_search_path(level, character)

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
          get api_v1_level_search_path('invalid_id', character)
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
