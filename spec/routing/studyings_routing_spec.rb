require 'rails_helper'

RSpec.describe StudyingsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'students/1/studyings').to route_to('studyings#index', student_id: '1')
    end

    it 'routes to #new' do
      expect(get: 'students/1/studyings/new').to route_to('studyings#new', student_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/studyings/1').to route_to('studyings#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/studyings/1/edit').to route_to('studyings#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: 'students/1/studyings').to route_to('studyings#create',student_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/studyings/1').to route_to('studyings#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/studyings/1').to route_to('studyings#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/studyings/1').to route_to('studyings#destroy', id: '1')
    end
  end
end
