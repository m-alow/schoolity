
class SchoolAdministration < ActiveRecord::Base
  belongs_to :administrator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :administrated_school, class_name: 'School', foreign_key: 'school_id'
end
