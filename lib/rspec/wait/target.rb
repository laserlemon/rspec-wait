require "rspec"

require "rspec/wait/handler"

module RSpec
  module Wait
    class Target < RSpec::Expectations::ExpectationTarget
      # From: https://github.com/rspec/rspec-expectations/blob/v2.14.5/lib/rspec/expectations/expectation_target.rb#L32-L35
      def to(matcher = nil, message = nil, &block)
        prevent_operator_matchers(:to, matcher)
        PositiveHandler.handle_matcher(@target, matcher, message, &block)
      end

      # From: https://github.com/rspec/rspec-expectations/blob/v2.14.5/lib/rspec/expectations/expectation_target.rb#L45-L48
      def not_to(matcher = nil, message = nil, &block)
        prevent_operator_matchers(:not_to, matcher)
        NegativeHandler.handle_matcher(@target, matcher, message, &block)
      end
    end
  end
end
