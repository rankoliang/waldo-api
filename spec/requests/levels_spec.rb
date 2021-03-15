require 'rails_helper'

RSpec.describe 'Levels', type: :request do
  subject!(:level) { FactoryBot.create('level') }

  describe 'GET /levels' do
    before :each do
      get levels_path
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
    context 'when the level is found' do
      before :each do
        get level_path(level)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns a JSON object containing the title' do
        data = JSON.parse(response.body)
        level = data['level']

        expect(level).to include('title')
      end
    end

    context 'when the level is not found' do
      before :each do
        get level_path('unknown_id')
      end

      it 'returns http not found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a JSON response containing an error' do
        data = JSON.parse(response.body)

        expect(data).to include 'error' => 'The level was not found.'
      end
    end
  end
end
