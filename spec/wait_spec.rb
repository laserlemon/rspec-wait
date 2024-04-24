# frozen_string_literal: true

RSpec.describe "wait" do
  attr_reader :ticker

  before do
    @ticker = ""

    Thread.new do
      11.times do
        sleep 1
        @ticker += "."
      end
    end
  end

  describe "for" do
    describe "to" do
      it "passes immediately" do
        expect {
          wait.for { ticker }.to eq("")
        }.not_to raise_error
      end

      it "waits for the matcher to pass" do
        expect {
          wait.for { ticker }.to eq(".")
        }.not_to raise_error
      end

      it "fails if the matcher never passes" do
        expect {
          wait.for { ticker }.to eq("." * 12)
        }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it "passes even if call time exceeds the timeout" do
        expect {
          wait.for {
            sleep 12
            ticker
          }.to eq("." * 11)
        }.not_to raise_error
      end

      it "respects a timeout specified in configuration" do
        original_timeout = RSpec.configuration.wait_timeout
        RSpec.configuration.wait_timeout = 3

        expect {
          wait.for { ticker }.to eq("." * 4)
        }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      ensure
        RSpec.configuration.wait_timeout = original_timeout
      end

      it "respects a timeout specified via with_wait" do
        original_timeout = RSpec.configuration.wait_timeout

        with_wait(timeout: 3) do
          expect {
            wait.for { ticker }.to eq("." * 4)
          }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
        end

        expect(RSpec.configuration.wait_timeout).to eq(original_timeout)
      end

      it "respects a timeout specified in example metadata", wait: { timeout: 3 } do
        expect {
          wait.for { ticker }.to eq("." * 4)
        }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it "respects a timeout specified as an argument" do
        expect {
          wait(3).for { ticker }.to eq("." * 4)
        }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it "respects a timeout specified as a keyword argument" do
        expect {
          wait(timeout: 3).for { ticker }.to eq("." * 4)
        }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it "raises an error occuring in the block" do
        expect {
          wait.for { raise StandardError, "boom" }.to eq("..")
        }.to raise_error(StandardError, "boom")
      end

      it "prevents operator matchers" do
        expect {
          wait.for { ticker }.to == "."
        }.to raise_error(ArgumentError, /operator matcher/)
      end

      it "only accepts a block" do
        expect {
          wait.for(ticker).to eq(".")
        }.to raise_error(ArgumentError, /block/)
      end

      it "waits for a block matcher when the expectation is met" do
        expect {
          wait.for { ticker }.not_to raise_error
        }.not_to raise_error
      end

      it "waits for a block matcher when the expectation is not met" do
        expect {
          wait.for { raise StandardError, "boom" }.not_to raise_error
        }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it "reuses the given matcher instance by default" do
        expect {
          wait_for { ticker }.to eq_with_bad_memoization("..")
        }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it "optionally clones the given matcher for each block call" do
        original_clone_matcher = RSpec.configuration.clone_wait_matcher
        RSpec.configuration.clone_wait_matcher = true

        expect {
          wait_for { ticker }.to eq_with_bad_memoization("..")
        }.not_to raise_error
      ensure
        RSpec.configuration.clone_wait_matcher = original_clone_matcher
      end

      it "respects a clone_matcher option specified via with_wait" do
        original_clone_matcher = RSpec.configuration.clone_wait_matcher

        with_wait(clone_matcher: true) do
          expect {
            wait_for { ticker }.to eq_with_bad_memoization("..")
          }.not_to raise_error
        end

        expect(RSpec.configuration.clone_wait_matcher).to eq(original_clone_matcher)
      end

      it "respects a clone_matcher option specified in example metadata", wait: { clone_matcher: true } do
        expect {
          wait_for { ticker }.to eq_with_bad_memoization("..")
        }.not_to raise_error
      end

      it "respects a clone_matcher option specified as a keyword argument" do
        expect {
          wait(clone_matcher: true).for { ticker }.to eq_with_bad_memoization("..")
        }.not_to raise_error
      end
    end

    describe "not_to" do
      it "passes immediately" do
        expect {
          wait.for { ticker }.not_to eq("..")
        }.not_to raise_error
      end

      it "waits for the matcher not to pass" do
        expect {
          wait.for { ticker }.not_to eq("")
        }.not_to raise_error
      end

      it "fails if the matcher always passes" do
        expect {
          wait.for { ticker }.not_to be_a(String)
        }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it "passes even if call time exceeds the timeout" do
        expect {
          wait.for {
            sleep 12
            ticker
          }.not_to eq("..")
        }.not_to raise_error
      end

      it "respects a timeout specified in configuration" do
        original_timeout = RSpec.configuration.wait_timeout
        RSpec.configuration.wait_timeout = 3

        expect {
          wait.for { ticker }.not_to match(/\A\.{0,4}\z/)
        }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      ensure
        RSpec.configuration.wait_timeout = original_timeout
      end

      it "respects a timeout specified via with_wait" do
        original_timeout = RSpec.configuration.wait_timeout

        with_wait(timeout: 3) do
          expect {
            wait.for { ticker }.not_to match(/\A\.{0,4}\z/)
          }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
        end

        expect(RSpec.configuration.wait_timeout).to eq(original_timeout)
      end

      it "respects a timeout specified in example metadata", wait: { timeout: 3 } do
        expect {
          wait.for { ticker }.not_to match(/\A\.{0,4}\z/)
        }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it "respects a timeout specified as an argument" do
        expect {
          wait(3).for { ticker }.not_to match(/\A\.{0,4}\z/)
        }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it "respects a timeout specified as a keyword argument" do
        expect {
          wait(timeout: 3).for { ticker }.not_to match(/\A\.{0,4}\z/)
        }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it "raises an error occuring in the block" do
        expect {
          wait.for { raise StandardError, "boom" }.not_to eq("")
        }.to raise_error(StandardError, "boom")
      end

      it "prevents operator matchers" do
        expect {
          wait.for { ticker }.not_to == ".."
        }.to raise_error(ArgumentError, /operator matcher/)
      end

      it "only accepts a block" do
        expect {
          wait.for(ticker).not_to eq("..")
        }.to raise_error(ArgumentError, /block/)
      end

      it "waits for a block matcher when the expectation is met" do
        expect {
          wait.for { ticker }.not_to raise_error
        }.not_to raise_error
      end

      it "waits for a block matcher when the expectation is not met" do
        expect {
          wait.for { raise StandardError, "boom" }.not_to raise_error
        }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end

    describe "to_not" do
      it "respects the to_not alias when the expectation is met" do
        expect {
          wait(1).for { true }.to_not eq(false) # rubocop:disable RSpec/NotToNot
        }.not_to raise_error
      end

      it "respects the to_not alias when the expectation is not met" do
        expect {
          wait(1).for { true }.to_not eq(true) # rubocop:disable RSpec/NotToNot
        }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end
end
