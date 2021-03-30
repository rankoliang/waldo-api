require 'rails_helper'

RSpec.describe 'Api::V1::Scores', type: :request do
  let(:level) { FactoryBot.create('level') }

  describe 'GET /levels/:id/leaderboard' do
    it 'returns http success' do
      get api_v1_level_leaderboard_index_path(level)

      expect(response).to have_http_status(:success)
    end

    context 'when there are scores' do
      it 'returns sorted array of scores' do
        level.scores.create(name: 'Anonymous1', milliseconds: 4520)
        level.scores.create(name: 'Anonymous2', milliseconds: 7621)
        level.scores.create(name: 'Anonymous3', milliseconds: 2362)

        get api_v1_level_leaderboard_index_path(level)

        scores = JSON.parse(response.body)
        expect(scores)
          .to include('level', 'scores' => [
                        { 'name' => 'Anonymous3', 'milliseconds' => 2362 },
                        { 'name' => 'Anonymous1', 'milliseconds' => 4520 },
                        { 'name' => 'Anonymous2', 'milliseconds' => 7621 }
                      ], 'pages' => 1)
      end
    end
  end

  describe 'POST /levels/:id/leaderboard' do
    let(:start_time) { Time.current }
    let(:end_time) { start_time + 2.minutes }
    let(:body) { JSON.parse(response.body) }
    let(:decrypted_data) { decrypt_and_verify(body['token']) }
    let(:time_elapsed) { ((start_time - end_time) * 1000).ceil }
    let(:token) do
      encrypt_and_sign({ 'start_time' => start_time,
                         'end_time' => end_time })
    end

    it 'creates a score' do
      expect do
        post api_v1_level_leaderboard_index_path(level),
             params: { name: 'Anonymous', token: token }
      end.to change { Score.count }.by(1)
    end

    it 'sets the correct number of milliseconds' do
      post api_v1_level_leaderboard_index_path(level),
           params: { name: 'Anonymous', token: token }

      expect(Score.order('created_at DESC').first.milliseconds).to eq(2 * 60 * 1000)
    end

    it 'returns http accepted' do
      post api_v1_level_leaderboard_index_path(level),
           params: { name: 'Anonymous', token: token }

      expect(response).to have_http_status :accepted
    end

    it 'returns the position score position' do
      level.scores.create(name: 'Anonymous', milliseconds: 1234)

      post api_v1_level_leaderboard_index_path(level),
           params: { name: 'Anonymous', token: token }

      body = JSON.parse(response.body)

      expect(body['position']).to eq(2)
    end

    context 'when the name is too short' do
      it 'returns an error' do
        post api_v1_level_leaderboard_index_path(level),
             params: { name: 'a', token: token }

        errors = JSON.parse(response.body)['errors']

        expect(errors).to include('name')
      end
    end
  end
end
