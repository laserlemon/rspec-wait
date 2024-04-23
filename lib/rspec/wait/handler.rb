# frozen_string_literal: true

require "timeout"

module RSpec
  module Wait
    # The RSpec::Wait::Handler module is common functionality shared between
    # the RSpec::Wait::PositiveHandler and RSpec::Wait::NegativeHandler classes
    # defined below. The module overrides RSpec's handle_matcher method,
    # allowing a block target to be repeatedly evaluated until the underlying
    # matcher passes or the configured timeout elapses.
    module Handler
      def handle_matcher(target, matcher, *args, &block)
        start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)

        begin
          if matcher.supports_block_expectations?
            super(target, matcher, *args, &block)
          else
            super(target.call, matcher, *args, &block)
          end
        rescue RSpec::Expectations::ExpectationNotMetError
          elapsed_time = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start_time
          raise if elapsed_time > RSpec.configuration.wait_timeout

          sleep RSpec.configuration.wait_delay
          retry
        end
      end
    end

    # From: https://github.com/rspec/rspec-expectations/blob/v3.0.0/lib/rspec/expectations/handler.rb#L44-L63
    class PositiveHandler < RSpec::Expectations::PositiveExpectationHandler
      extend Handler
    end

    # From: https://github.com/rspec/rspec-expectations/blob/v3.0.0/lib/rspec/expectations/handler.rb#L66-L93
    class NegativeHandler < RSpec::Expectations::NegativeExpectationHandler
      extend Handler
    end
  end
end
