require "rspec"
require "timeout"

require "rspec/wait/error"

module RSpec
  module Wait
    module Handler
   	  if defined?(RSpec.configuration.wait_timeout) then
		TIMEOUT=RSpec.configuration.wait_timeout
	  else
		TIMEOUT=10
	  end
      DELAY = 0.1
	  

      def handle_matcher(target, *args, &block)
        failure = nil

        Timeout.timeout(TIMEOUT) do
          loop do
            begin
              actual = target.respond_to?(:call) ? target.call : target
              super(actual, *args, &block)
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
