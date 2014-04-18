require "rspec"

require "rspec/wait/error"
require "rspec/wait/handler"
require "rspec/wait/target"

module RSpec
  module Wait
    # From: https://github.com/rspec/rspec-expectations/blob/v2.14.5/lib/rspec/expectations/syntax.rb#L83-L87
    def wait_for(*target, &target_block)
      target << target_block if block_given?
      raise ArgumentError.new("You must pass an argument or a block to #wait_for but not both.") unless target.size == 1
      Target.new(target.first)
    end
  end
end

RSpec.configure do |config|
  config.include(RSpec::Wait)
end
