# frozen_string_literal: true

# The examples below fully describe the wait_for interface used in your RSpec
# examples. They exist as *shared* examples because we use this one file to
# identically test the behavior of both wait_for and wait.for. The wait method
# is a convenience for passing additional options. That options handling is
# tested separately in wait_proxy_spec.rb, in addition to the examples below.
RSpec.shared_examples "wait_for" do
  let(:ticker) { Ticker.new(timeout: 11) }

  before do
    ticker.start
  end

  after do
    ticker.stop
  end

  describe "to" do
    it "passes immediately" do
      expect_pass do
        target { ticker.tape }.to eq("")
      end
    end

    it "waits for the matcher to pass" do
      expect_pass do
        target { ticker.tape }.to eq(".")
      end
    end

    it "fails if the matcher never passes" do
      expect_fail do
        target { ticker.length }.to eq(12)
      end
    end

    it "stops calling its block if RSpec is shutting down" do
      with_rspec_shutting_down_in(1.5) do
        failure =
          expect_fail do
            target { ticker.tape }.to eq("..")
          end

        expect(failure.message).to match(%(expected: ".."))
        expect(failure.message).to match(%(got: "."))
      end
    end

    it "passes even if call time exceeds the timeout" do
      expect_pass do
        target {
          sleep 12
          ticker.length
        }.to eq(11)
      end
    end

    it "respects a timeout specified in configuration" do
      original_timeout = RSpec.configuration.wait_timeout
      RSpec.configuration.wait_timeout = 3

      expect_fail do
        target { ticker.length }.to eq(4)
      end
    ensure
      RSpec.configuration.wait_timeout = original_timeout
    end

    it "respects a timeout specified via with_wait" do
      original_timeout = RSpec.configuration.wait_timeout

      with_wait(timeout: 3) do
        expect_fail do
          target { ticker.length }.to eq(4)
        end
      end

      expect(RSpec.configuration.wait_timeout).to eq(original_timeout)
    end

    it "respects a timeout specified in example metadata", wait: { timeout: 3 } do
      expect_fail do
        target { ticker.length }.to eq(4)
      end
    end

    it "raises an error occuring in the block" do
      expect_error(StandardError, "boom") do
        target { raise StandardError, "boom" }.to eq(".")
      end
    end

    it "prevents operator matchers" do
      expect_error(ArgumentError, /operator matcher/) do
        target { ticker.tape }.to == "."
      end
    end

    it "only accepts a block" do
      expect_error(ArgumentError, /block/) do
        target(ticker.tape).to eq(".")
      end
    end

    it "requires a block" do
      expect_error(ArgumentError, /block/) do
        target.to eq(".")
      end
    end

    it "waits for a block matcher when the expectation is met" do
      expect_pass do
        target { raise StandardError, "boom" }.to raise_error(StandardError, "boom")
      end
    end

    it "waits for a block matcher when the expectation is not met" do
      expect_fail do
        target { ticker.tape }.to raise_error(StandardError)
      end
    end

    it "reuses the given matcher instance by default" do
      expect_fail do
        target { ticker.tape }.to eq_with_bad_memoization(".")
      end
    end

    it "optionally clones the given matcher for each block call" do
      original_clone_matcher = RSpec.configuration.clone_wait_matcher
      RSpec.configuration.clone_wait_matcher = true

      expect_pass do
        target { ticker.tape }.to eq_with_bad_memoization(".")
      end
    ensure
      RSpec.configuration.clone_wait_matcher = original_clone_matcher
    end

    it "respects a clone_matcher option specified via with_wait" do
      original_clone_matcher = RSpec.configuration.clone_wait_matcher

      with_wait(clone_matcher: true) do
        expect_pass do
          target { ticker.tape }.to eq_with_bad_memoization(".")
        end
      end

      expect(RSpec.configuration.clone_wait_matcher).to eq(original_clone_matcher)
    end

    it "respects a clone_matcher option specified in example metadata", wait: { clone_matcher: true } do
      expect_pass do
        target { ticker.tape }.to eq_with_bad_memoization(".")
      end
    end
  end

  describe "not_to" do
    it "passes immediately" do
      expect_pass do
        target { ticker.tape }.not_to eq(".")
      end
    end

    it "waits for the matcher not to pass" do
      expect_pass do
        target { ticker.tape }.not_to eq("")
      end
    end

    it "fails if the matcher always passes" do
      expect_fail do
        target { ticker.tape }.not_to be_a(String)
      end
    end

    it "passes even if call time exceeds the timeout" do
      expect_pass do
        target {
          sleep 12
          ticker.length
        }.not_to eq(0)
      end
    end

    it "respects a timeout specified in configuration" do
      original_timeout = RSpec.configuration.wait_timeout
      RSpec.configuration.wait_timeout = 3

      expect_fail do
        target { ticker.length }.not_to be < 4
      end
    ensure
      RSpec.configuration.wait_timeout = original_timeout
    end

    it "respects a timeout specified via with_wait" do
      original_timeout = RSpec.configuration.wait_timeout

      with_wait(timeout: 3) do
        expect_fail do
          target { ticker.length }.not_to be < 4
        end
      end

      expect(RSpec.configuration.wait_timeout).to eq(original_timeout)
    end

    it "respects a timeout specified in example metadata", wait: { timeout: 3 } do
      expect_fail do
        target { ticker.length }.not_to be < 4
      end
    end

    it "raises an error occuring in the block" do
      expect_error(StandardError, "boom") do
        target { raise StandardError, "boom" }.not_to eq(".")
      end
    end

    it "prevents operator matchers" do
      expect_error(ArgumentError, /operator matcher/) do
        target { ticker.tape }.not_to == "."
      end
    end

    it "only accepts a block" do
      expect_error(ArgumentError, /block/) do
        target(ticker.tape).not_to eq(".")
      end
    end

    it "requires a block" do
      expect_error(ArgumentError, /block/) do
        target.not_to eq(".")
      end
    end

    it "waits for a block matcher when the expectation is met" do
      expect_pass do
        target { ticker.tape }.not_to raise_error
      end
    end

    it "waits for a block matcher when the expectation is not met" do
      expect_fail do
        target { raise StandardError, "boom" }.not_to raise_error
      end
    end
  end

  describe "to_not" do
    it "respects the to_not alias when the expectation is met" do
      expect_pass do
        target { true }.to_not eq(false) # rubocop:disable RSpec/NotToNot
      end
    end

    it "respects the to_not alias when the expectation is not met" do
      expect_fail do
        target { true }.to_not eq(true) # rubocop:disable RSpec/NotToNot
      end
    end
  end
end
