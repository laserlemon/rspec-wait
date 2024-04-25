# frozen_string_literal: true

RSpec.describe "wait_for" do
  include_examples "wait_for" do
    def target(...)
      wait_for(...)
    end
  end
end
