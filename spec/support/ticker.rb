# frozen_string_literal: true

# A Ticker is a sort of clock that appends a "." to its `tape` once every
# second, up to `timeout` times. Ticker#start starts the clock and Ticker#stop
# stops it. The ticker appends to its tape in a background thread, making it
# useful for assertions that wait for a specific condition to be met.
class Ticker
  attr_reader :timeout, :tape

  def initialize(timeout:)
    @timeout = timeout
    @tape = ""
  end

  def start
    @ticking =
      Thread.new do
        timeout.times do
          sleep 1
          @tape += "."
        end
      end
  end

  def length
    tape.length
  end

  def stop
    @ticking&.kill
  end
end
