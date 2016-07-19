require 'rails_helper'

RSpec.describe MessagesController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: 'messages/1').to route_to('messages#show', id: '1')
    end
  end
end
