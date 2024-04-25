# frozen_string_literal: true

# This is a contrived example of a poorly designed matcher that memoizes the
# actual value it's given, which makes repeated checks impossible.
RSpec::Matchers.define :eq_with_bad_memoization do |expected|
  match do |actual|
    @memo ||= actual
    @actual = @memo
    @memo == expected
  end
end
