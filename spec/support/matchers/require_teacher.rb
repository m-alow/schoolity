RSpec::Matchers.define :require_teacher do |expected|
  match do |actual|
    expect(actual).to render_template 'shared/non_teacher'
  end

  failure_message do |actual|
    'expected to require that current user is teacher'
  end

  failure_message_when_negated do |actual|
    'expect not to require that current user is teacher'
  end

  description do
    'renders a message showing the current user that he is not a teacher.'
  end
end
