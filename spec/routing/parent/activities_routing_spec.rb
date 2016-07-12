require 'rails_helper'

RSpec.describe Parent::ActivitiesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'parent/followings/1/activities').to route_to('parent/activities#index', following_id: '1')
    end
  end
end
