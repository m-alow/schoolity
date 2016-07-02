require 'rails_helper'

RSpec.describe LessonsController, type: :routing do
  describe 'routing' do
    it 'routes to #update' do
      expect(put: 'lessons/1').to route_to('lessons#update', id: '1')
    end

    it 'routes to #update_qualified' do
      expect(put: 'classrooms/1/lessons/2010-10-5/2').to route_to('lessons#update_qualified', classroom_id: '1', date: '2010-10-5', order: '2')
    end
  end
end
