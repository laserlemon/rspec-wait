# frozen_string_literal: true

# The helper methods defined by PassFailExpectations are available in the
# context of an RSpec example. Their purpose is to clean up common assertions
# for readability.
module PassFailExpectations
  def expect_pass(&block)
    expect(&block).not_to raise_error
  end

  def expect_fail(&block)
    expect(&block).to raise_error(RSpec::Expectations::ExpectationNotMetError) do |error|
      return error
    end
  end

  def expect_error(*args, &block)
    expect(&block).to raise_error(*args) do |error|
      return error
    end
  end
end

RSpec.configure do |config|
  config.include(PassFailExpectations)
end
