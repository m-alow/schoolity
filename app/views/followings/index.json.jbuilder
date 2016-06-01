json.array!(@followings) do |following|
  json.extract! following, :id, :user_id, :student_id, :relationship
  json.url following_url(following, format: :json)
end
