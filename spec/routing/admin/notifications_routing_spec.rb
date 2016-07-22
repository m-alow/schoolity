require 'rails_helper'

RSpec.describe Admin::NotificationsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'admin/notifications').to route_to('admin/notifications#index')
    end

    it 'routes to #all' do
      expect(get: 'admin/notifications/all').to route_to('admin/notifications#all')
    end
  end
end
