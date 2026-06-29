require "rails_helper"

RSpec.describe Api::V1::AlbumsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/v1/albums").to route_to("albums#index")
    end

    it "routes to #show" do
      expect(get: "/api/v1/albums/1").to route_to("albums#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/api/v1/albums").to route_to("albums#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/api/v1/albums/1").to route_to("albums#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/api/v1/albums/1").to route_to("albums#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/api/v1/albums/1").to route_to("albums#destroy", id: "1")
    end
  end
end
