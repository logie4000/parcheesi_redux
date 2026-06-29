require 'rails_helper'

RSpec.describe 'Radio Shows API', type: :request do
  # initialize test data
  let!(:size_radio_show_list) { 1 }

  let!(:user) { create(:dee_jay) }

  let!(:radio_shows) { create_list(:radio_show, size_radio_show_list) }
  let(:radio_show_id) { radio_shows.first.id }
    
  let(:headers) { valid_headers }

  # Test suite for GET /api/v1/radio_shows
  describe 'GET /api/v1/radio_shows' do
    # make HTTP request before each example
    before { get '/api/v1/radio_shows', params: {}, headers: headers }

    it 'returns radio_shows' do
      # Note that 'json' is a custom helper
      expect(json).not_to be_empty
      expect(json.size).to eq(size_radio_show_list)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/radio_shows/:id
  describe 'GET /api/v1/radio_shows/:id' do
    before { get "/api/v1/radio_shows/#{radio_show_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the radio_show' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(radio_show_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:radio_show_id) {size_radio_show_list + 10}
 
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

#      it 'returns a not found message' do
#        expect(response).to match(/Couldn't find/)
#      end
    end
  end
end
