require 'rails_helper'

RSpec.describe Parent::FollowingsController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: 'parent/followings/1').to route_to('parent/followings#show', id: '1')
    end
  end
end
