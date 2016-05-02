class SignInForm
  include Capybara::DSL

  def visit_page
    visit '/'
    click_on 'Login'
    self
  end

  def fill_in_with(params = {})
    fill_in 'Email', with: params.fetch(:email, 'me@mail.com')
    fill_in 'Password', with: params.fetch(:password, '123123123')
    self
  end

  def submit
    click_on 'Log in'
    self
  end
end
