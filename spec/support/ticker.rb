# frozen_string_literal: true

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
