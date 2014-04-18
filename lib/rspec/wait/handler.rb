require "rspec"
require "timeout"

require "rspec/wait/error"

module RSpec
  module Wait
    module Handler
      TIMEOUT = 10
      DELAY = 0.1

      # From: https://github.com/rspec/rspec-expectations/blob/v2.14.5/lib/rspec/expectations/handler.rb#L16-L64
      def handle_matcher(actual, *)
        failure = nil

        Timeout.timeout(TIMEOUT) do
          loop do
            actual = actual.call if actual.respond_to?(:call)

            begin
              super
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

    class PositiveHandler < RSpec::Expectations::PositiveExpectationHandler
      extend Handler
    end

    class NegativeHandler < RSpec::Expectations::NegativeExpectationHandler
      extend Handler
    end
  end
end
