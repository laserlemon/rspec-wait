# frozen_string_literal: true

require "rspec"
require "rspec/wait/handler"
require "rspec/wait/proxy"
require "rspec/wait/target"
require "rspec/wait/version"

module RSpec
  # The RSpec::Wait module is included into RSpec's example environment, making
  # the wait_for, wait, and with_wait methods available inside each spec.
  module Wait
    DEFAULT_TIMEOUT = 10
    DEFAULT_DELAY = 0.1

    module_function

    # From: https://github.com/rspec/rspec-expectations/blob/v3.4.0/lib/rspec/expectations/syntax.rb#L72-L74
    def wait_for(*args, &block)
      raise ArgumentError, "The `wait_for` method only accepts a block." if args.any?

      Target.new(block)
    end

    def wait(timeout = nil, options = {})
      options[:timeout] = timeout if timeout
      Proxy.new(options)
    end

    def with_wait(options)
      original_timeout = RSpec.configuration.wait_timeout
      original_delay = RSpec.configuration.wait_delay

      RSpec.configuration.wait_timeout = options[:timeout] if options[:timeout]
      RSpec.configuration.wait_delay = options[:delay] if options[:delay]

      yield
    ensure
      RSpec.configuration.wait_timeout = original_timeout
      RSpec.configuration.wait_delay = original_delay
    end
  end
end

RSpec.configure do |config|
  config.include(RSpec::Wait)

  config.add_setting(:wait_timeout, default: RSpec::Wait::DEFAULT_TIMEOUT)
  config.add_setting(:wait_delay, default: RSpec::Wait::DEFAULT_DELAY)

  config.around(wait: {}) do |example|
    options = example.metadata.fetch(:wait)
    with_wait(options) { example.run }
  end
end
