require 'rails_helper'

RSpec.describe Students::AnnouncementsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/students/1/announcements').to route_to('students/announcements#index', student_id: '1')
    end

    it 'routes to #new' do
      expect(get: '/students/1/announcements/new').to route_to('students/announcements#new', student_id: '1')
    end

    it 'routes to #create' do
      expect(post: '/students/1/announcements').to route_to('students/announcements#create', student_id: '1')
    end
  end
end
