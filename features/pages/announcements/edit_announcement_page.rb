class EditAnnouncementForm
  extend Capybara::DSL

  def self.visit_page_from_school announcement
    AnnouncementPage.visit_page_from_school announcement
    click_on 'Edit'
    self
  end

  def self.fill_in_with params = {}
    fill_in 'Title', with: params[:title]
    fill_in_trix_editor "announcement_body_trix_input_announcement_#{params[:id]}", params[:body]
    self
  end

  def self.submit
    click_on 'Submit'
    self
  end
end
