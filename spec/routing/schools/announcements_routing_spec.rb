require 'rails_helper'

RSpec.describe Schools::AnnouncementsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/schools/1/announcements').to route_to('schools/announcements#index', school_id: '1')
    end

    it 'routes to #new' do
      expect(get: '/schools/1/announcements/new').to route_to('schools/announcements#new', school_id: '1')
    end

    it 'routes to #create' do
      expect(post: '/schools/1/announcements').to route_to('schools/announcements#create', school_id: '1')
    end
  end
end
