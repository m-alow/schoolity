require 'rails_helper'

RSpec.describe Parent::MessagesController, type: :routing do
  describe 'routing' do
    it 'routes to #new' do
      expect(get: 'parent/followings/1/messages/new').to route_to('parent/messages#new', following_id: '1')
    end

    it 'routes to #create' do
      expect(post: 'parent/followings/1/messages').to route_to('parent/messages#create', following_id: '1')
    end
  end
end
