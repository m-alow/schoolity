require 'rails_helper'

RSpec.describe Parent::AgendasController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'parent/followings/1/agendas').to route_to('parent/agendas#index', following_id: '1')
    end

    it 'routes to #show' do
      expect(get: 'parent/followings/1/agendas/2010-10-5').to route_to('parent/agendas#show', following_id: '1', date: '2010-10-5')
    end
  end
end
