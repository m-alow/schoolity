require 'rails_helper'

RSpec.describe Parent::BehaviorsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'parent/followings/1/behaviors').to route_to('parent/behaviors#index', following_id: '1')
    end
  end
end
