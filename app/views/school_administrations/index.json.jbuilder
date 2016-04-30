json.array!(@school_administrations) do |school_administration|
  json.extract! school_administration, :id, :user_id, :school_id
  json.url school_administration_url(school_administration, format: :json)
end
