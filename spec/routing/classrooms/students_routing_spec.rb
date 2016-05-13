
  require 'rails_helper'

RSpec.describe Classrooms::StudentsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/classrooms/1/students').to route_to('classrooms/students#index', classroom_id: '1')
    end

    it 'routes to #new' do
      expect(get: '/classrooms/1/students/new').to route_to('classrooms/students#new', classroom_id: '1')
    end

    it 'routes to #create' do
      expect(post: 'classrooms/1/students').to route_to('classrooms/students#create', classroom_id: '1')
    end
  end
end
