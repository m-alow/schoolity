require 'rails_helper'

RSpec.describe MessagesController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: 'messages/1').to route_to('messages#show', id: '1')
    end

    it 'routes to #index' do
      expect(get: 'schools/1/messages').to route_to('messages#index', school_id: '1')
    end

    it 'routes to #index_category' do
      expect(get: 'schools/1/messages/suggestions').to route_to('messages#index_category', category: 'suggestions', school_id: '1')
    end
  end
end
