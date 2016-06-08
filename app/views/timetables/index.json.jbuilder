json.array!(@timetables) do |timetable|
  json.extract! timetable, :id, :classroom_id, :active, :weekends, :periods_number
  json.url timetable_url(timetable, format: :json)
end
