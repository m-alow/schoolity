class Day::PersistedOnDate
  def call classroom, date
    Day::OnDate.new.call(classroom, date).tap do |day_result|
      if day_result.status == :study_day && !day_result.day.persisted?
        day_result.day.save!
      end
    end
  end
end
