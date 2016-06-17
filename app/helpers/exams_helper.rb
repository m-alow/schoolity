module ExamsHelper
  def allowed_subjects
    if current_user.teaches_all_subjects_in_classroom? @classroom
      @classroom.school_class.subjects
    else
      current_user.teachings.includes(:subject).where(classroom: @classroom).map(&:subject)
    end
  end
end
