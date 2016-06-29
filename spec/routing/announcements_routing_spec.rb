require 'rails_helper'

RSpec.describe AnnouncementsController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/announcements/1').to route_to('announcements#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/announcements/1/edit').to route_to('announcements#edit', id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/announcements/1').to route_to('announcements#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/announcements/1').to route_to('announcements#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: 'announcements/1').to route_to('announcements#destroy', id: '1')
    end
  end
end
