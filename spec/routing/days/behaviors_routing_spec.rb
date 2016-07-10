require 'rails_helper'

RSpec.describe Days::BehaviorsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'days/1/behaviors').to route_to('days/behaviors#index', day_id: '1')
    end

    it 'routes to #edit' do
      expect(get: 'days/1/behaviors/edit').to route_to('days/behaviors#edit', day_id: '1')
    end

    it 'routes to #update' do
      expect(put: 'days/1/students/2/behavior').to route_to('days/behaviors#update', day_id: '1', student_id: '2')
    end
  end
end
