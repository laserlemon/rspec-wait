# frozen_string_literal: true

RSpec.describe "wait_for" do
  let(:progress) { +"" }

  before do
    Thread.new do
      11.times do
        sleep 1
        progress << "."
      end
    end
  end

  describe "to" do
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
        wait_for { progress }.to eq("." * 12)
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

    it "passes even if call time exceeds the timeout" do
      expect {
        wait_for {
          sleep 12
          progress
        }.to eq("." * 11)
      }.not_to raise_error
    end

    it "respects a timeout specified in configuration" do
      original_timeout = RSpec.configuration.wait_timeout
      RSpec.configuration.wait_timeout = 3

      expect {
        wait_for { progress }.to eq("." * 4)
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    ensure
      RSpec.configuration.wait_timeout = original_timeout
    end

    it "respects a timeout specified in example metadata", wait: { timeout: 3 } do
      expect {
        wait_for { progress }.to eq("." * 4)
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

    it "raises an error occuring in the block" do
      expect {
        wait_for { raise StandardError, "boom" }.to eq("..")
      }.to raise_error(StandardError, "boom")
    end

    it "prevents operator matchers" do
      expect {
        wait_for { progress }.to == "."
      }.to raise_error(ArgumentError, /operator matcher/)
    end

    it "only accepts a block" do
      expect {
        wait_for(progress).to eq(".")
      }.to raise_error(ArgumentError, /block/)
    end
  end

  describe "not_to" do
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

    it "passes even if call time exceeds the timeout" do
      expect {
        wait_for {
          sleep 12
          progress
        }.not_to eq("..")
      }.not_to raise_error
    end

    it "respects a timeout specified in configuration" do
      original_timeout = RSpec.configuration.wait_timeout
      RSpec.configuration.wait_timeout = 3

      expect {
        wait_for { progress }.not_to match(/\A\.{0,3}\z/)
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    ensure
      RSpec.configuration.wait_timeout = original_timeout
    end

    it "respects a timeout specified in example metadata", wait: { timeout: 3 } do
      expect {
        wait_for { progress }.not_to match(/\A\.{0,3}\z/)
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

    it "raises an error occuring in the block" do
      expect {
        wait_for { raise StandardError, "boom" }.not_to eq("")
      }.to raise_error(StandardError, "boom")
    end

    it "prevents operator matchers" do
      expect {
        wait_for { progress }.not_to == ".."
      }.to raise_error(ArgumentError, /operator matcher/)
    end

    it "only accepts a block" do
      expect {
        wait_for(progress).not_to eq("..")
      }.to raise_error(ArgumentError, /block/)
    end

    it "respects the to_not alias when expectation is met" do
      expect {
        wait_for { true }.to_not eq(false) # rubocop:disable RSpec/NotToNot
      }.not_to raise_error
    end

    it "respects the to_not alias when expectation is not met" do
      expect {
        wait_for { true }.to_not eq(true) # rubocop:disable RSpec/NotToNot
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end
end
