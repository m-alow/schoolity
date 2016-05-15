require 'rails_helper'

RSpec.describe TeachingsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'classrooms/1/teachings').to route_to('teachings#index', classroom_id: '1')
    end

    it 'routes to #new' do
      expect(get: '/classrooms/1/teachings/new').to route_to('teachings#new', classroom_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/teachings/1').to route_to('teachings#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/teachings/1/edit').to route_to('teachings#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/classrooms/1/teachings').to route_to('teachings#create', classroom_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/teachings/1').to route_to('teachings#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/teachings/1').to route_to('teachings#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/teachings/1').to route_to('teachings#destroy', id: '1')
    end
  end
end
