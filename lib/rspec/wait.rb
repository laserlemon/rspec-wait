require "rspec"

require "rspec/wait/error"
require "rspec/wait/handler"
require "rspec/wait/target"

module RSpec
  module Wait
    # From: https://github.com/rspec/rspec-expectations/blob/v3.0.0/lib/rspec/expectations/syntax.rb#L72-L74
    def wait_for(*args, &block)
      if args.any? || block.nil?
        raise ArgumentError, "You must pass only a block to `wait_for`."
      end

      Target.new(block)
    end
  end
end

RSpec.configure do |config|
  config.include(RSpec::Wait)
end
