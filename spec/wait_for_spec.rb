require "spec_helper"

describe "wait_for" do
  let!(:progress) { "" }

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
        wait_for(progress).to eq("")
      }.not_to raise_error
    end

    it "waits for the matcher to pass" do
      expect {
        wait_for(progress).to eq(".")
      }.not_to raise_error
    end

    it "accepts a block" do
      expect {
        wait_for { progress.dup }.to eq(".")
      }.not_to raise_error
    end

    it "fails if the matcher never passes" do
      expect {
        wait_for(progress).to eq("...")
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

    it "times out if the block never finishes" do
      expect {
        wait_for { sleep 11; progress }.to eq("..")
      }.to raise_error(RSpec::Wait::TimeoutError)
    end

    it "raises an error occuring in the block" do
      expect {
        wait_for { raise RuntimeError }.to eq("..")
      }.to raise_error(RuntimeError)
    end
  end

  context "not_to" do
    it "passes immediately" do
      expect {
        wait_for(progress).not_to eq("..")
      }.not_to raise_error
    end

    it "waits for the matcher not to pass" do
      expect {
        wait_for(progress).not_to eq("")
      }.not_to raise_error
    end

    it "accepts a block" do
      expect {
        wait_for { progress.dup }.not_to eq("")
      }.not_to raise_error
    end

    it "fails if the matcher always passes" do
      expect {
        wait_for(progress).not_to be_a(String)
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

    it "times out if the block never finishes" do
      expect {
        wait_for { sleep 11; progress }.not_to eq("..")
      }.to raise_error(RSpec::Wait::TimeoutError)
    end

    it "raises an error occuring in the block" do
      expect {
        wait_for { raise RuntimeError }.not_to eq("")
      }.to raise_error(RuntimeError)
    end

    it "respects the to_not alias" do
      expect {
        wait_for(progress).to_not eq("..")
      }.not_to raise_error
    end
  end
end
