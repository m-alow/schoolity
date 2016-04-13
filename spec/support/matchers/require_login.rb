RSpec::Matchers.define :require_login do |expected|
  match do |actual|
    expect(actual).to redirect_to Rails.application.routes.url_helpers.new_user_session_path
  end

  failure_message do |actual|
    'expected to require login'
  end

  failure_message_when_negated do |actual|
    'expect not to require login'
  end

  description do
    'redirect to the login form'
  end
end
