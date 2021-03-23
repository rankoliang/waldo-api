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

  describe 'POST /levels/:id/leaderboard' do
    it 'creates a score' do
      expect do
        post api_v1_level_leaderboard_index_path(level),
             params: { score: { name: 'Anonymous', milliseconds: 1234 } }
      end.to change { Score.count }.by(1)
    end

    it 'returns http accepted' do
      post api_v1_level_leaderboard_index_path(level),
           params: { score: { name: 'Anonymous', milliseconds: 1234 } }

      expect(response).to have_http_status :accepted
    end
  end
end
