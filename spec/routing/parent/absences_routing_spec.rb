require 'rails_helper'

RSpec.describe Parent::AbsencesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'parent/followings/1/absences').to route_to('parent/absences#index', following_id: '1')
    end
  end
end
