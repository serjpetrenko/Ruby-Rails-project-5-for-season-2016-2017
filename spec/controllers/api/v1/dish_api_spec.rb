require 'rails_helper'

describe API::V1::DishAPI, type: :request do
  let(:dish) { create(:dish) }

  before do
    allow(UsersHelper).to receive(:authorize).and_return(true)
    header 'Content-Type', 'application/vnd.api+json'
  end

  describe 'GET /api/v1/dishes' do
    before do
      dish
      get '/api/v1/dishes'
      json
    end

    it 'returns HTTP status 200' do
      expect(last_response.status).to eq 200
    end

    it 'returns all dishes' do
      expect(json.size).to eq(1)
    end
  end
end
