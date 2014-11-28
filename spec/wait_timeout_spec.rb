require "timeout_helper"
require "spec_helper"
	


describe "timeout" do
  let!(:progress) { "" }

  before do
    Thread.new do
      2.times do
        sleep 1
        progress << "."
      end
    end

  end
  
  it "can be changed using RSpec.configure" do
    expect {
      wait_for { sleep 3; progress }.not_to eq("..")
    }.to raise_error(RSpec::Wait::TimeoutError)
  end

end
