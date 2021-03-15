require 'rails_helper'

RSpec.describe 'Api::V1::Characters', type: :request do
  subject(:character) { FactoryBot.create('character') }
  let(:level) { character.level }

  describe 'GET /levels/:level_id/characters' do
    context 'when the level is found' do
      it 'returns http success' do
        get api_v1_level_characters_path(level)
        expect(response).to have_http_status(:success)
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
          get api_v1_level_search_path(level, character)
          expect(response).to have_http_status(:success)
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
