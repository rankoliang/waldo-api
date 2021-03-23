require 'rails_helper'

RSpec.describe 'Api::V1::Scores', type: :request do
  let(:level) { FactoryBot.create('level') }

  describe 'GET /levels/:id/leaderboard' do
    it 'returns http success' do
      get api_v1_level_leaderboard_index_path(level)

      expect(response).to have_http_status(:success)
    end

    context 'when there are scores' do
      it 'returns an array of scores' do
        level.scores.create(name: 'Anonymous', milliseconds: 4520)
        get api_v1_level_leaderboard_index_path(level)

        scores = JSON.parse(response.body)
        expect(scores).to eq(['name' => 'Anonymous', 'milliseconds' => 4520])
      end
    end
  end
end
