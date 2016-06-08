require 'rails_helper'

RSpec.describe TimetablesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/classrooms/1/timetables').to route_to('timetables#index', classroom_id: '1')
    end

    it 'routes to #init' do
      expect(get: '/classrooms/1/timetables/new/initialize').to route_to('timetables#init', classroom_id: '1')
    end

    it 'routes to #new' do
      expect(get: '/classrooms/1/timetables/new').to route_to('timetables#new', classroom_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/timetables/1').to route_to('timetables#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/timetables/1/edit').to route_to('timetables#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/classrooms/1/timetables').to route_to('timetables#create', classroom_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/timetables/1').to route_to('timetables#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/timetables/1').to route_to('timetables#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/timetables/1').to route_to('timetables#destroy', id: '1')
    end
  end
end
