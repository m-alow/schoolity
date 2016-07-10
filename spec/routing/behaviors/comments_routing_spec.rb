require 'rails_helper'

RSpec.describe Behaviors::CommentsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: 'behaviors/1/comments').to route_to('behaviors/comments#create', behavior_id: '1')
    end
  end
end
