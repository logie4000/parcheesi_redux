require "rails_helper"

RSpec.describe DeeJaysController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/dee_jays").to route_to("dee_jays#index")
    end

    it "routes to #show" do
      expect(get: "/dee_jays/1").to route_to("dee_jays#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/dee_jays").to route_to("dee_jays#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/dee_jays/1").to route_to("dee_jays#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/dee_jays/1").to route_to("dee_jays#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/dee_jays/1").to route_to("dee_jays#destroy", id: "1")
    end
  end
end
