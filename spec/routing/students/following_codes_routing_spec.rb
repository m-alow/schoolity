require 'rails_helper'

RSpec.describe Students::FollowingCodesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
       expect(get: '/students/1/following_codes').to route_to('students/following_codes#index', student_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/following_codes/1').to route_to('students/following_codes#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/students/1/following_codes').to route_to('students/following_codes#create', student_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/following_codes/1').to route_to('students/following_codes#destroy', id: '1')
    end
  end
end
