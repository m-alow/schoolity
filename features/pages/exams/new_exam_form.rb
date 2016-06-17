class NewExamForm
  extend Capybara::DSL

  def self.visit_page classroom
    visit "/classrooms/#{classroom.id}/exams/new"
    self
  end

  def self.fill_in_with params = {}
    fill_in 'Score', with: params[:score]
    fill_in 'Minimum score', with: params[:minimum_score]
    select params[:subject], from: 'Subject'

    params[:scores].each_with_index do |score, i|
      fill_in "exam_grades_attributes_#{i}_score", with: score
    end
    self
  end

  def self.submit
    click_on 'Create Exam'
    self
  end
end
