require "rspec"

require "rspec/wait/handler"

module RSpec
  module Wait
    class Target < RSpec::Expectations::ExpectationTarget
      # From: https://github.com/rspec/rspec-expectations/blob/v3.0.0/lib/rspec/expectations/expectation_target.rb#L53-L54
      def to(matcher = nil, message = nil, &block)
        prevent_operator_matchers(:to, matcher) unless matcher
        PositiveHandler.handle_matcher(@target, matcher, message, &block)
      end

      # From: https://github.com/rspec/rspec-expectations/blob/v3.0.0/lib/rspec/expectations/expectation_target.rb#L66-L67
      def not_to(matcher = nil, message = nil, &block)
        prevent_operator_matchers(:not_to, matcher) unless matcher
        NegativeHandler.handle_matcher(@target, matcher, message, &block)
      end
    end
  end
end
