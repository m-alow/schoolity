require 'rails_helper'

RSpec.describe BehaviorsController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/behaviors/1').to route_to('behaviors#show', id: '1')
    end
  end
end
