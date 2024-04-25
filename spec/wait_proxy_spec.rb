# frozen_string_literal: true

RSpec.describe "wait" do
  describe "for" do
    include_examples "wait_for" do
      def target(...)
        wait.for(...)
      end
    end

    describe "to" do
      it "respects a timeout specified as an argument" do
        expect_fail do
          wait(3).for { ticker.length }.to eq(4)
        end
      end

      it "respects a timeout specified as a keyword argument" do
        expect_fail do
          wait(timeout: 3).for { ticker.length }.to eq(4)
        end
      end

      it "respects a clone_matcher option specified as a keyword argument" do
        expect_pass do
          wait(clone_matcher: true).for { ticker.tape }.to eq_with_bad_memoization(".")
        end
      end
    end

    describe "not_to" do
      it "respects a timeout specified as an argument" do
        expect_fail do
          wait(3).for { ticker.length }.not_to be < 4
        end
      end

      it "respects a timeout specified as a keyword argument" do
        expect_fail do
          wait(timeout: 3).for { ticker.length }.not_to be < 4
        end
      end
    end
  end
end
