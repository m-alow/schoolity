require 'rails_helper'

RSpec.describe AgendasController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'classrooms/1/agendas').to route_to('agendas#index', classroom_id: '1')
    end

    # it 'routes to #new' do
    #   expect(get: '/classrooms/1/agendas/new').to route_to('agendas#new', classroom_id: '1')
    # end

    it 'routes to #today' do
      expect(get:'/classrooms/1/agendas/today').to route_to('agendas#today', classroom_id: '1')
    end

    # it 'routes to #show' do
    #   expect(get: '/agendas/1').to route_to('agendas#show', id: '1')
    # end

    it 'routes to #show_by_date' do
      expect(get: '/classrooms/1/agendas/2010/10/10').to route_to('agendas#show_by_date',
                                                                  classroom_id: '1' , year: '2010', month: '10', day: '10')
    end

    it 'routes to #edit' do
      expect(get: '/agendas/1/edit').to route_to('agendas#edit', id: '1')
    end

    # it 'routes to #create' do
    #   expect(post: '/classrooms/1/agendas').to route_to('agendas#create', classroom_id: '1')
    # end

    it 'routes to #update via PUT' do
      expect(put: '/agendas/1').to route_to('agendas#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/agendas/1').to route_to('agendas#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/agendas/1').to route_to('agendas#destroy', id: '1')
    end
  end
end
