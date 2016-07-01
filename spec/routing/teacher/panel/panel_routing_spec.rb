require 'rails_helper'

RSpec.describe Teacher::PanelController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'teacher/').to route_to('teacher/panel#index')
    end
  end
end
