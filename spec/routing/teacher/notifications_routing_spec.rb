require 'rails_helper'

RSpec.describe Teacher::NotificationsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'teacher/notifications').to route_to('teacher/notifications#index')
    end

    it 'routes to #all' do
      expect(get: 'teacher/notifications/all').to route_to('teacher/notifications#all')
    end
  end
end
