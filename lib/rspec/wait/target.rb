# frozen_string_literal: true

module RSpec
  module Wait
    # The RSpec::Wait::Target class inherits from RSpec's internal
    # RSpec::Expectations::ExpectationTarget class and allows the inclusion of
    # RSpec::Wait options via RSpec::Wait::Proxy.
    class Target < RSpec::Expectations::ExpectationTarget
      # From: https://github.com/rspec/rspec-expectations/blob/v3.0.0/lib/rspec/expectations/expectation_target.rb#L22
      UndefinedValue = Module.new

      # From: https://github.com/rspec/rspec-expectations/blob/v3.0.0/lib/rspec/expectations/expectation_target.rb#L30-L41
      def self.for(value, block, options = {})
        if UndefinedValue.equal?(value) && block
          new(block, options)
        else
          raise ArgumentError, "The wait_for method only accepts a block."
        end
      end

      # From: https://github.com/rspec/rspec-expectations/blob/v3.0.0/lib/rspec/expectations/expectation_target.rb#L25-L27
      def initialize(block, options)
        @wait_options = options
        @target = block
      end

      # From: https://github.com/rspec/rspec-expectations/blob/v3.0.0/lib/rspec/expectations/expectation_target.rb#L53-L54
      def to(matcher = nil, message = nil, &block)
        prevent_operator_matchers(:to) unless matcher

        with_wait do
          PositiveHandler.handle_matcher(@target, matcher, message, &block)
        end
      end

      # From: https://github.com/rspec/rspec-expectations/blob/v3.0.0/lib/rspec/expectations/expectation_target.rb#L66-L67
      def not_to(matcher = nil, message = nil, &block)
        prevent_operator_matchers(:not_to) unless matcher

        with_wait do
          NegativeHandler.handle_matcher(@target, matcher, message, &block)
        end
      end

      alias to_not not_to

      private

      def with_wait(&block)
        Wait.with_wait(@wait_options, &block)
      end
    end
  end
end
