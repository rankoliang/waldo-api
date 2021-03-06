require 'rails_helper'

RSpec.describe 'Levels', type: :request do
  subject!(:level) do
    level = FactoryBot.create('level')
    character = FactoryBot.create('character')
    level.search_areas.create(**attributes_for(:search_area), character: character)

    level
  end

  describe 'GET /levels' do
    before :each do
      get api_v1_levels_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns a JSON array of all of the levels' do
      levels = JSON.parse(response.body)
      expect(levels.length).to eq 1
    end
  end

  describe 'GET /levels/:id' do
    let(:start_time) { Time.current }
    let(:body) { JSON.parse(response.body) }
    let(:decrypted_data) { decrypt_and_verify(body['token']) }

    context 'when the level is found' do
      it 'returns http success' do
        get api_v1_level_path(level)

        expect(response).to have_http_status(:success)
      end

      it 'returns a JSON object containing the title' do
        get api_v1_level_path(level)

        level = JSON.parse(response.body, symbolize_names: true)

        expect(level).to include(:title)
      end

      it 'sets the start time token' do
        freeze_time do
          get api_v1_level_path(level)

          expect(decrypted_data).to include('start_time' => start_time)
        end
      end

      it 'sets the searches to 0' do
        get api_v1_level_path(level)

        expect(decrypted_data['characters_found']).to eq(
          {
            level.characters.first.id => false
          }
        )
      end
    end

    context 'when the level is not found' do
      before :each do
        get api_v1_level_path('invalid_id')
      end

      it 'returns http not found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a JSON response containing an error' do
        data = JSON.parse(response.body, symbolize_names: true)

        expect(data).to include error: 'The level was not found.'
      end
    end
  end
end
