require 'rails_helper'

RSpec.describe 'Levels', type: :request do
  subject(:level) { FactoryBot.create('level') }

  describe 'GET /levels' do
    it 'returns http success' do
      get levels_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /levels/:id' do
    context 'when the level exists' do
      it 'returns http success' do
        get level_path(level)
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the level does not exist' do
      it 'returns http not found' do
        get level_path('unknown_id')
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
