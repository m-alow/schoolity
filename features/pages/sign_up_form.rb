class SignUpForm
  include Capybara::DSL

  def visit_page
    visit '/'
    click_on 'Join'
    self
  end

  def fill_in_with(params = {})
    fill_in 'First name', with: params.fetch(:first_name, 'Mohammad')
    fill_in 'Last name', with: params.fetch(:last_name, 'Alow')
    fill_in 'Email', with: params.fetch(:email, 'me@mail.com')
    fill_in 'Password', with: params.fetch(:password, '123123123')
    fill_in 'Password confirmation', with: params.fetch(:password_confirmation, '123123123')
    self
  end

  def submit
    click_on 'Sign up'
    self
  end
end
