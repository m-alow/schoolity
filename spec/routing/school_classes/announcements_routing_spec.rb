require 'rails_helper'

RSpec.describe SchoolClasses::AnnouncementsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/school_classes/1/announcements').to route_to('school_classes/announcements#index', school_class_id: '1')
    end

    it 'routes to #new' do
      expect(get: '/school_classes/1/announcements/new').to route_to('school_classes/announcements#new', school_class_id: '1')
    end

    it 'routes to #create' do
      expect(post: '/school_classes/1/announcements').to route_to('school_classes/announcements#create', school_class_id: '1')
    end
  end
end
