require 'rails_helper'

RSpec.describe Parent::PanelController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'parent/').to route_to('parent/panel#index')
    end
  end
end
