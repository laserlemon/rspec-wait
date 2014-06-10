require "rspec"
require "timeout"

require "rspec/wait/error"

module RSpec
  module Wait
    module Handler
      TIMEOUT = 10
      DELAY = 0.1

      def handle_matcher(actual, *args, &block)
        failure = nil

        Timeout.timeout(TIMEOUT) do
          loop do
            begin
              super(actual.call, *args, &block)
              break
            rescue RSpec::Expectations::ExpectationNotMetError => failure
              sleep DELAY
              retry
            end
          end
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
