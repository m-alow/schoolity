module ExamsHelper
  def allowed_subjects
    current_user.teachings.includes(:subject).where(classroom: @classroom).map(&:subject)
  end
end
