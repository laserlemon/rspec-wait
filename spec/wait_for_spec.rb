describe "wait_for" do
  let(:progress) { "" }

  before do
    Thread.new do
      2.times do
        sleep 1
        progress << "."
      end
    end
  end

  context "to" do
    it "passes immediately" do
      expect {
        wait_for { progress }.to eq("")
      }.not_to raise_error
    end

    it "waits for the matcher to pass" do
      expect {
        wait_for { progress }.to eq(".")
      }.not_to raise_error
    end

    it "re-evaluates the actual value" do
      expect {
        wait_for { progress.dup }.to eq(".")
      }.not_to raise_error
    end

    it "fails if the matcher never passes" do
      expect {
        wait_for { progress }.to eq("...")
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

    it "times out if the block never finishes" do
      expect {
        wait_for {
          sleep 11
          progress
        }.to eq("..")
      }.to raise_error(RSpec::Wait::TimeoutError)
    end

    it "respects a timeout specified in configuration" do
      original_timeout = RSpec.configuration.wait_timeout
      RSpec.configuration.wait_timeout = 3

      begin
        expect {
          wait_for {
            sleep 4
            progress
          }.to eq("..")
        }.to raise_error(RSpec::Wait::TimeoutError)
      ensure
        RSpec.configuration.wait_timeout = original_timeout
      end
    end

    it "respects a timeout specified in options", wait: { timeout: 3 } do
      expect {
        wait_for {
          sleep 4
          progress
        }.to eq("..")
      }.to raise_error(RSpec::Wait::TimeoutError)
    end

    it "raises an error occuring in the block" do
      expect {
        wait_for { raise RuntimeError }.to eq("..")
      }.to raise_error(RuntimeError)
    end

    it "prevents operator matchers" do
      expect {
        wait_for { progress }.to == "."
      }.to raise_error(ArgumentError, /operator matcher/)
    end

    it "accepts a value rather than a block" do
      expect {
        wait_for(progress).to eq(".")
      }.not_to raise_error
    end

    it "waits for block matchers when expectation is met" do
      expect {
        wait_for { raise RuntimeError }.to raise_error(RuntimeError)
      }.not_to raise_error
    end

    it "waits for block matchers when expectation is not met" do
      expect {
        wait_for { progress }.to raise_error(RuntimeError)
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end

  context "not_to" do
    it "passes immediately" do
      expect {
        wait_for { progress }.not_to eq("..")
      }.not_to raise_error
    end

    it "waits for the matcher not to pass" do
      expect {
        wait_for { progress }.not_to eq("")
      }.not_to raise_error
    end

    it "re-evaluates the actual value" do
      expect {
        wait_for { progress.dup }.not_to eq("")
      }.not_to raise_error
    end

    it "fails if the matcher always passes" do
      expect {
        wait_for { progress }.not_to be_a(String)
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

    it "times out if the block never finishes" do
      expect {
        wait_for {
          sleep 11
          progress
        }.not_to eq("..")
      }.to raise_error(RSpec::Wait::TimeoutError)
    end

    it "respects a timeout specified in configuration" do
      original_timeout = RSpec.configuration.wait_timeout
      RSpec.configuration.wait_timeout = 3

      begin
        expect {
          wait_for {
            sleep 4
            progress
          }.not_to eq("..")
        }.to raise_error(RSpec::Wait::TimeoutError)
      ensure
        RSpec.configuration.wait_timeout = original_timeout
      end
    end

    it "respects a timeout specified in options", wait: { timeout: 3 } do
      expect {
        wait_for {
          sleep 4
          progress
        }.not_to eq("..")
      }.to raise_error(RSpec::Wait::TimeoutError)
    end

    it "raises an error occuring in the block" do
      expect {
        wait_for { raise RuntimeError }.not_to eq("")
      }.to raise_error(RuntimeError)
    end

    it "respects the to_not alias when expectation is met" do
      expect {
        wait_for { true }.to_not eq(false)
      }.not_to raise_error
    end

    it "respects the to_not alias when expectation is not met" do
      expect {
        wait_for { true }.to_not eq(true)
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

    it "prevents operator matchers" do
      expect {
        wait_for { progress }.not_to == ".."
      }.to raise_error(ArgumentError, /operator matcher/)
    end

    it "accepts a value rather than a block" do
      expect {
        wait_for(progress).not_to eq("..")
      }.not_to raise_error
    end

    it "waits for block matchers when expectation is met" do
      expect {
        wait_for { progress }.not_to raise_error
      }.not_to raise_error
    end

    it "waits for block matchers when expectation is not met" do
      expect {
        wait_for { raise RuntimeError }.not_to raise_error
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
