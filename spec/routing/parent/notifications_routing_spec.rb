require 'rails_helper'

RSpec.describe Parent::NotificationsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'parent/notifications').to route_to('parent/notifications#index')
    end

    it 'routes to #all' do
      expect(get: 'parent/notifications/all').to route_to('parent/notifications#all')
    end
  end
end
