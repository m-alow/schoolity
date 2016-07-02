require 'rails_helper'

RSpec.describe Teacher::PanelController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'teacher/').to route_to('teacher/panel#index')
    end

    it 'routes to #exams' do
      expect(get: 'teacher/exams').to route_to('teacher/panel#exams')
    end

    it 'routes to #announcements' do
      expect(get: 'teacher/announcements').to route_to('teacher/panel#announcements')
    end
  end
end
