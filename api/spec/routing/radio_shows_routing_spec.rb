require "rails_helper"

RSpec.describe Api::V1::RadioShowsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/v1/radio_shows").to route_to("radio_shows#index")
    end

    it "routes to #show" do
      expect(get: "/api/v1/radio_shows/1").to route_to("radio_shows#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/api/v1/radio_shows").to route_to("radio_shows#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/api/v1/radio_shows/1").to route_to("radio_shows#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/api/v1/radio_shows/1").to route_to("radio_shows#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/api/v1/radio_shows/1").to route_to("radio_shows#destroy", id: "1")
    end
  end
end
