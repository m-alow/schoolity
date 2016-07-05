require 'rails_helper'

RSpec.describe Parent::GradesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'parent/followings/1/grades').to route_to('parent/grades#index', following_id: '1')
    end
  end
end
