require 'rails_helper'

RSpec.describe GradesController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/grades/1').to route_to('grades#show', id: '1')
    end
  end
end
