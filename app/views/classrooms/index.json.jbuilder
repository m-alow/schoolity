json.array!(@classrooms) do |classroom|
  json.extract! classroom, :id, :school_class_id, :name
  json.url classroom_url(classroom, format: :json)
end
