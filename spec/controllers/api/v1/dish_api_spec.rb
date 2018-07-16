require 'rails_helper'

describe API::V1::DishAPI, type: :request do
  include Rack::Test::Methods

  let(:user) { create(:user) }
  
  before do
    UsersHelper.authorize(user)
    header 'Content-Type', 'application/vnd.api+json'
  end

  describe 'GET /api/v1/dishes' do
    it 'returns HTTP status 200' do
      get '/api/v1/dishes'
      expect(last_response.status).to eq 200
    end
  end
end
