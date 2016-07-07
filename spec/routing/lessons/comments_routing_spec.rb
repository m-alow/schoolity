require 'rails_helper'

RSpec.describe Lessons::CommentsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: 'lessons/1/comments').to route_to('lessons/comments#create', lesson_id: '1')
    end
  end
end
