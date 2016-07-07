require 'rails_helper'

RSpec.describe Activities::CommentsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: 'activities/1/comments').to route_to('activities/comments#create', activity_id: '1')
    end
  end
end
