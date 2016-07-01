require 'rails_helper'

RSpec.describe Teacher::AgendasController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'teacher/agendas').to route_to('teacher/agendas#index')
    end

    it 'routes to #show' do
      expect(get: 'teacher/agendas/2010-10-5').to route_to('teacher/agendas#show', date: '2010-10-5')
    end

    it 'routes to #edit' do
      expect(get: 'teacher/agendas/2010-10-5/edit').to route_to('teacher/agendas#edit', date: '2010-10-5')
    end
  end
end
