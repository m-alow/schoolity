RSpec::Matchers.define :require_parent do |expected|
  match do |actual|
    expect(actual).to render_template 'shared/non_parent'
  end

  failure_message do |actual|
    'expected to require that current user is parent'
  end

  failure_message_when_negated do |actual|
    'expect not to require that current user is parent'
  end

  description do
    'renders a message showing the current user that he is not a parent.'
  end
end
