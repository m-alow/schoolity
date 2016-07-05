require 'rails_helper'

RSpec.describe Grades::CommentsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/grades/1/comments').to route_to('grades/comments#create', grade_id: '1')
    end
  end
end
