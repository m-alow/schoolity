require 'rails_helper'

RSpec.describe Absences::CommentsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: 'absences/1/comments').to route_to('absences/comments#create', absence_id: '1')
    end
  end
end
