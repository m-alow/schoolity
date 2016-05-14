json.array!(@subjects) do |subject|
  json.extract! subject, :id, :name, :school_class_id
  json.url subject_url(subject, format: :json)
end
