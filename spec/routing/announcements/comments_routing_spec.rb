require 'rails_helper'

RSpec.describe Announcements::CommentsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/announcements/1/comments').to route_to('announcements/comments#create', announcement_id: '1')
    end
  end
end
