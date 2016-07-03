require 'rails_helper'

RSpec.describe Parent::FeedController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'parent/feed').to route_to('parent/feed#index')
    end
  end
end
