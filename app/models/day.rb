require 'roles/day'

class Day < ActiveRecord::Base
  belongs_to :classroom
  has_many :lessons

  serialize :content

  validates :classroom, :content_type, :date, presence: true
  validates :date, uniqueness: { scope: :classroom_id }

  TYPE_TO_ROLE = {
    'base' => Roles::Day::Base,
    'basic' => Roles::Day::Basic
  }

  after_initialize do
    self.content_type ||= 'base'
    extend TYPE_TO_ROLE[content_type]
    initialize_content
  end
end
