require "rails_helper"

RSpec.describe ClassroomsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/schools/1/school_classes/1/classrooms").to route_to("classrooms#index", school_id: '1', school_class_id: '1')
    end

    it "routes to #new" do
      expect(:get => "/schools/1/school_classes/1/classrooms/new").to route_to("classrooms#new", school_id: '1', school_class_id: '1')
    end

    it "routes to #show" do
      expect(:get => "/schools/1/school_classes/1/classrooms/1").to route_to("classrooms#show", school_id: '1', school_class_id: '1', id: '1')
    end

    it "routes to #edit" do
      expect(:get => "/schools/1/school_classes/1/classrooms/1/edit").to route_to("classrooms#edit", school_id: '1', school_class_id: '1', id: '1')
    end

    it "routes to #create" do
      expect(:post => "/schools/1/school_classes/1/classrooms").to route_to("classrooms#create", school_id: '1', school_class_id: '1')
    end

    it "routes to #update via PUT" do
      expect(:put => "/schools/1/school_classes/1/classrooms/1").to route_to("classrooms#update", school_id: '1', school_class_id: '1', id: '1')
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/schools/1/school_classes/1/classrooms/1").to route_to("classrooms#update", school_id: '1', school_class_id: '1', id: '1')
    end

    it "routes to #destroy" do
      expect(:delete => "/schools/1/school_classes/1/classrooms/1").to route_to("classrooms#destroy", school_id: '1', school_class_id: '1', id: '1')
    end

  end
end
