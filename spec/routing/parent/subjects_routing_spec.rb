require 'rails_helper'

RSpec.describe Parent::SubjectsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'parent/followings/1/subjects').to route_to('parent/subjects#index', following_id: '1')
    end
  end
end
