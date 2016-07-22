require 'rails_helper'

RSpec.describe Admin::PanelController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'admin/').to route_to('admin/panel#index')
    end
  end
end
