require 'rails_helper'

RSpec.describe 'Levels', type: :request do
  subject!(:level) { FactoryBot.create('level') }

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

    context 'when the level is found' do
      it 'returns http success' do
        get api_v1_level_path(level)

        expect(response).to have_http_status(:success)
      end

      it 'returns a JSON object containing the title' do
        get api_v1_level_path(level)

        data = JSON.parse(response.body, symbolize_names: true)
        level = data[:level]

        expect(level).to include(:title)
      end

      it 'sets the start time cookie' do
        freeze_time do
          get api_v1_level_path(level)

          jar = build_jar(request, cookies)

          expect(jar.signed['start_time']).to eq(start_time)
        end
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
