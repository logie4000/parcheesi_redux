require "rails_helper"

RSpec.describe Api::V1::ArtistsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/v1/artists").to route_to("api/v1/artists#index")
    end

    it "routes to #show" do
      expect(get: "/api/v1/artists/1").to route_to("api/v1/artists#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/api/v1/artists").not_to be_routable
    end

    it "routes to #update via PUT" do
      expect(put: "/api/v1/artists/1").not_to be_routable
    end

    it "routes to #update via PATCH" do
      expect(patch: "/api/v1/artists/1").not_to be_routable
    end

    it "routes to #destroy" do
      expect(delete: "/api/v1/artists/1").not_to be_routable
    end
  end
end
