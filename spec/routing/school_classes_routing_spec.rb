require "rails_helper"

RSpec.describe SchoolClassesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/schools/1/school_classes").to route_to("school_classes#index", :school_id => "1")
    end

    it "routes to #new" do
      expect(:get => "/schools/1/school_classes/new").to route_to("school_classes#new", :school_id => "1")
    end

    it "routes to #show" do
      expect(:get => "/schools/1/school_classes/1").to route_to("school_classes#show", :id => "1", :school_id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/schools/1/school_classes/1/edit").to route_to("school_classes#edit", :id => "1", :school_id => "1")
    end

    it "routes to #create" do
      expect(:post => "/schools/1/school_classes").to route_to("school_classes#create", :school_id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/schools/1/school_classes/1").to route_to("school_classes#update", :id => "1", :school_id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/schools/1/school_classes/1").to route_to("school_classes#update", :id => "1", :school_id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/schools/1/school_classes/1").to route_to("school_classes#destroy", :id => "1", :school_id => "1")
    end

  end
end
