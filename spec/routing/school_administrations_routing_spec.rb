require "rails_helper"

RSpec.describe SchoolAdministrationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "schools/1/school_administrations").to route_to("school_administrations#index", school_id: '1')
    end

    it "routes to #new" do
      expect(:get => "schools/1/school_administrations/new").to route_to("school_administrations#new", school_id: '1')
    end

    it "routes to #show" do
      expect(:get => "/school_administrations/1").to route_to("school_administrations#show", id: '1')
    end

    it "routes to #edit" do
      expect(:get => "/school_administrations/1/edit").to route_to("school_administrations#edit", id: '1')
    end

    it "routes to #create" do
      expect(:post => "schools/1/school_administrations").to route_to("school_administrations#create", school_id: '1')
    end

    it "routes to #update via PUT" do
      expect(:put => "/school_administrations/1").to route_to("school_administrations#update", id: '1')
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/school_administrations/1").to route_to("school_administrations#update", id: '1')
    end

    it "routes to #destroy" do
      expect(:delete => "/school_administrations/1").to route_to("school_administrations#destroy", id: '1')
    end

  end
end
