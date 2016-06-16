require 'rails_helper'

RSpec.describe ActivitiesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'lessons/1/activities').to route_to('activities#index', lesson_id: '1')
    end

    it 'routes to #edit' do
      expect(get: 'lessons/1/activities/edit').to route_to('activities#edit', lesson_id: '1')
    end

    it 'routes to #update' do
      expect(put: 'lessons/1/students/2/activity').to route_to('activities#update', lesson_id: '1', student_id: '2')
    end
  end
end
