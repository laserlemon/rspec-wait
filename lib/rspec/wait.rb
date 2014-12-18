require "rspec"

require "rspec/wait/error"
require "rspec/wait/handler"
require "rspec/wait/target"

module RSpec
  module Wait
    # From: https://github.com/rspec/rspec-expectations/blob/v3.0.0/lib/rspec/expectations/syntax.rb#L72-L74
    def wait_for(value = Target::UndefinedValue, &block)
      Target.for(value, block)
    end
  end
end

RSpec.configure do |config|
  config.include(RSpec::Wait)

  config.add_setting(:wait_timeout, default: 10)
  config.add_setting(:wait_delay, default: 0.1)
end
