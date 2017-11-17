module RSpec
  module Wait
    module Handler
      def handle_matcher(target, *args, &block) # rubocop:disable Metrics/MethodLength
        secs = RSpec.configuration.wait_timeout
        t = Time.now

        begin
          actual = target.respond_to?(:call) ? target.call : target
          # TODO: raise TimeoutError if the block takes too long
          val = super(actual, *args, &block)
          raise TimeoutError if Time.now - t > secs   # HAX!
          val
        rescue RSpec::Expectations::ExpectationNotMetError => failure
          if Time.now - t < secs
            sleep RSpec.configuration.wait_delay
            retry
          end
          raise failure
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
