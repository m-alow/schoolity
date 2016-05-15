json.array!(@teachings) do |teaching|
  json.extract! teaching, :id, :user_id, :classroom_id, :subject_id, :all_subjects
  json.url teaching_url(teaching, format: :json)
end
