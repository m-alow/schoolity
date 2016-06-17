class EditExamForm
  extend Capybara::DSL

  def self.visit_page exam
    visit "/exams/#{exam.id}/edit"
    self
  end

  def self.fill_in_with params = {}
    fill_in 'Score', with: params[:score]
    fill_in 'Minimum score', with: params[:minimum_score]

    params[:scores].each_with_index do |score, i|
      fill_in "exam_grades_attributes_#{i}_score", with: score
    end
    self
  end

  def self.submit
    click_on 'Update Exam'
    self
  end
end
