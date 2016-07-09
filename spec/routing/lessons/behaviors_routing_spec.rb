require 'rails_helper'

RSpec.describe Lessons::BehaviorsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'lessons/1/behaviors').to route_to('lessons/behaviors#index', lesson_id: '1')
    end

    it 'routes to #edit' do
      expect(get: 'lessons/1/behaviors/edit').to route_to('lessons/behaviors#edit', lesson_id: '1')
    end

    it 'routes to #update' do
      expect(put: 'lessons/1/students/2/behavior').to route_to('lessons/behaviors#update', lesson_id: '1', student_id: '2')
    end
  end
end
