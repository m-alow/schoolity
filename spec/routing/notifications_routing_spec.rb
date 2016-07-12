require 'rails_helper'

RSpec.describe NotificationsController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/notifications/1').to route_to('notifications#show', id: '1')
    end

    it 'routes to #update' do
      expect(put: '/notifications/1').to route_to('notifications#update', id: '1')
    end
  end
end
