require 'rails_helper'

RSpec.describe AbsencesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'days/1/absences').to route_to('absences#index', day_id: '1')
    end

    it 'routes to #update' do
      expect(put: 'days/1/students/2/absence').to route_to('absences#update', day_id: '1', student_id: '2')
    end

    it 'routes to #destroy' do
      expect(delete: 'absences/1').to route_to('absences#destroy', id: '1')
    end
  end
end
