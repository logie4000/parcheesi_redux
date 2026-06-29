require 'rails_helper'

RSpec.describe 'DeeJays API', type: :request do
  # initialize test data
  let!(:size_dee_jay_list) { 5 }
  let!(:dee_jays) { create_list(:dee_jay, size_dee_jay_list) }
  let(:dee_jay_id) { dee_jays.first.id }
  let!(:radio_show) { create(:radio_show, dee_jay_id: dee_jay_id) }
  
  let!(:user) { dee_jays.first }
  let(:headers) { valid_headers }

  # Test suite for GET /api/v1/dee_jays
  describe 'GET /api/v1/dee_jays' do
    # make HTTP request before each example
    before { get '/api/v1/dee_jays', params: {}, headers: headers }

    it 'returns dee_jays' do
      # Note that 'json' is a custom helper
      expect(json).not_to be_empty
      expect(json.size).to eq(size_dee_jay_list)
	  
	  json.each do |deejay|
		  expect(deejay['password_digest']).to be_nil
	  end
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/dee_jays/:id
  describe 'GET /api/v1/dee_jays/:id' do
    context 'when the record exists' do
	  before { get "/api/v1/dee_jays/#{dee_jay_id}", params: {}, headers: headers }

      it 'returns the dee_jay' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(dee_jay_id)
		    expect(json['password_digest']).to be_nil
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
	  before {
	    @dee_jay_id = size_dee_jay_list + 10
	    get "/api/v1/dee_jays/#{@dee_jay_id}", params: {}, headers: headers 
	  }
      
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

#      it 'returns a not found message' do
#        expect(response).to match(/Couldn't find/)
#      end
    end
  end
end
