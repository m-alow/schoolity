require 'rails_helper'

RSpec.describe Messages::CommentsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/messages/1/comments').to route_to('messages/comments#create', message_id: '1')
    end
  end
end
