# frozen_string_literal: true

module RSpecShutdown
  def with_rspec_shutting_down_in(seconds)
    original_wants_to_quit = :unknown
    wants_to_quit_thread =
      Thread.new do
        sleep seconds
        original_wants_to_quit = RSpec.world.wants_to_quit
        RSpec.world.wants_to_quit = true
      end

    yield
  ensure
    wants_to_quit_thread&.kill
    RSpec.world.wants_to_quit = original_wants_to_quit unless original_wants_to_quit == :unknown
  end
end

RSpec.configure do |config|
  config.include(RSpecShutdown)
end
