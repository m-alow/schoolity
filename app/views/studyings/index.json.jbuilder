json.array!(@studyings) do |studying|
  json.extract! studying, :id, :classroom_id, :student_id, :beginning_date, :end_date
  json.url studying_url(studying, format: :json)
end
