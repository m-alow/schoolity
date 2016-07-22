require 'rails_helper'

RSpec.describe Admin::FeedController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'admin/feed').to route_to('admin/feed#index')
    end
  end
end
