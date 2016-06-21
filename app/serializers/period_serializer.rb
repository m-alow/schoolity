class PeriodSerializer < ActiveModel::Serializer
  attributes :day, :order, :subject

  def subject
    object.subject&.name || ""
  end
end
