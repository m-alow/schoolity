require 'rails_helper'

RSpec.describe Classrooms::AnnouncementsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/classrooms/1/announcements').to route_to('classrooms/announcements#index', classroom_id: '1')
    end

    it 'routes to #new' do
      expect(get: '/classrooms/1/announcements/new').to route_to('classrooms/announcements#new', classroom_id: '1')
    end

    it 'routes to #create' do
      expect(post: '/classrooms/1/announcements').to route_to('classrooms/announcements#create', classroom_id: '1')
    end
  end
end
