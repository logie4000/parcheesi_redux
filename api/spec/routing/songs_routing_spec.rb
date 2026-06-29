require "rails_helper"

RSpec.describe Api::V1::SongsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/v1/songs").to route_to("api/v1/songs#index")
    end

    it "routes to #show" do
      expect(get: "/api/v1/songs/1").to route_to("api/v1/songs#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/api/v1/songs").to route_to("api/v1/songs#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/api/v1/songs/1").to route_to("api/v1/songs#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/api/v1/songs/1").to route_to("api/v1/songs#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/api/v1/songs/1").not_to be_routable
    end
  end
end
