class NewAnnouncementForm
  extend Capybara::DSL

  def self.visit_page_from_school school
    SchoolPage.visit_page school
    click_on 'New Announcement'
    self
  end

  def self.fill_in_with params = {}
    fill_in 'Title', with: params[:title]
    fill_in_trix_editor 'announcement_body_trix_input_announcement', params[:body]
    self
  end

  def self.submit
    click_on 'Submit'
    self
  end
end
