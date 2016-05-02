require_relative '../pages/sign_in_form'

def sign_in_user(user)
  SignInForm.new.
    visit_page.
    fill_in_with(
      email: user.email,
      password: user.password
    ).submit
end
