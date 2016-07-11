require 'rails_helper'

RSpec.describe Teacher::FeedController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'teacher/feed').to route_to('teacher/feed#index')
    end
  end
end
