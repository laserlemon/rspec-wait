# frozen_string_literal: true

module RSpec
  module Wait
    Error = Class.new(StandardError)
    TimeoutError = Class.new(Error)
  end
end
