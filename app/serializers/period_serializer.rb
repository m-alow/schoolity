class PeriodSerializer < ActiveModel::Serializer
  belongs_to :subject
  attributes :day, :order, :subject

  def subject
    ActiveModelSerializers::SerializableResource.new object.subject
  end
end
