class CommentForm
  extend Capybara::DSL

  def self.fill_in_with body
    fill_in 'comment_body', with: body
    self
  end

  def self.submit
    click_on 'Comment'
    self
  end
end
