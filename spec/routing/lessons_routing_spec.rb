require 'rails_helper'

RSpec.describe LessonsController, type: :routing do
  describe 'routing' do
    it 'routes to #update' do
      expect(put: 'lessons/1').to route_to('lessons#update', id: '1')
    end
  end
end
