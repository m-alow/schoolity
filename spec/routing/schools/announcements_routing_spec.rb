require 'rails_helper'

RSpec.describe Schools::AnnouncementsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/schools/1/announcements').to route_to('schools/announcements#index', school_id: '1')
    end

    it 'routes to #new' do
      expect(get: '/schools/1/announcements/new').to route_to('schools/announcements#new', school_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/announcements/1').to route_to('schools/announcements#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/announcements/1/edit').to route_to('schools/announcements#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/schools/1/announcements').to route_to('schools/announcements#create', school_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/announcements/1').to route_to('schools/announcements#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/announcements/1').to route_to('schools/announcements#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: 'announcements/1').to route_to('schools/announcements#destroy', id: '1')
    end
  end
end
