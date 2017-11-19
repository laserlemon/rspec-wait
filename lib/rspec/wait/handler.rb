require "timeout"

module RSpec
  module Wait
    module Handler
      def handle_matcher(target, *args, &block) # rubocop:disable Metrics/MethodLength
        failure = nil
        t = Time.now

        begin
          elapsed = Time.now - t
          to = RSpec.configuration.wait_timeout - elapsed
          raise Timeout::Error if to <= 0
          Timeout.timeout(to) do
            actual = target.respond_to?(:call) ? target.call : target
            super(actual, *args, &block)
          end
        rescue RSpec::Expectations::ExpectationNotMetError => failure
          sleep RSpec.configuration.wait_delay
          retry
        end
      rescue Timeout::Error
        raise failure || TimeoutError
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
