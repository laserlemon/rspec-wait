# RSpec::Wait

Wait for conditions in RSpec

[![Gem Version](https://img.shields.io/gem/v/rspec-wait.svg)](http://badge.fury.io/rb/rspec-wait)
[![Build Status](https://img.shields.io/travis/laserlemon/rspec-wait/master.svg)](https://travis-ci.org/laserlemon/rspec-wait)
[![Code Climate](https://img.shields.io/codeclimate/github/laserlemon/rspec-wait.svg)](https://codeclimate.com/github/laserlemon/rspec-wait)
[![Coverage Status](https://img.shields.io/codeclimate/coverage/github/laserlemon/rspec-wait.svg)](https://codeclimate.com/github/laserlemon/rspec-wait)
[![Dependency Status](https://img.shields.io/gemnasium/laserlemon/rspec-wait.svg)](https://gemnasium.com/laserlemon/rspec-wait)

## Why does RSpec::Wait exist?

Timing is hard.

Timing problems and race conditions can plague your test suite. As your test
suite slowly becomes less reliable, development speed and quality suffer.

RSpec::Wait strives to make it easier to test asynchronous or slow interactions.

## How does RSpec::Wait work?

RSpec::Wait allows you to wait for an assertion to pass, using the RSpec
syntactic sugar that you already know and love.

RSpec::Wait will keep trying until your assertion passes or times out.

### Example

RSpec::Wait's assertions are drop-in replacements for RSpec's `expect`
assertions.

```ruby
describe Stopwatch do
  subject(:stopwatch) { Stopwatch.new }

  describe "#start" do
    before do
      stopwatch.start
    end

    it "starts at 0" do
      expect(stopwatch.seconds).to eq(0)
    end

    it "counts to 3" do
      wait_for(stopwatch.seconds).to eq(3)
    end
  end
end
```

This can be especially useful for testing user interactions containing tricky
timing elements.

```ruby
feature "User Login" do
  let!(:user) { create(:user, name: "John Doe", email: "john@example.com", password: "secret") }

  scenario "A user can log in successfully" do
    visit new_session_path

    fill_in "Email", with: "john@example.com"
    fill_in "Password", with: "secret"
    click_button "Log In"

    wait_for { current_path }.to eq(account_path)
    expect(page).to have_content("John Doe")
  end
end
```

## Who wrote RSpec::Wait?

My name is Steve Richert and I wrote RSpec::Wait in April, 2014 with the support
of my employer, [Collective Idea](http://www.collectiveidea.com). RSpec::Wait
owes its current and future success entirely to [inspiration](https://github.com/laserlemon/rspec-wait/issues)
and [contribution](https://github.com/laserlemon/rspec-wait/graphs/contributors)
from the Ruby community, especially the [authors and maintainers](https://github.com/rspec/rspec-core/graphs/contributors)
of RSpec.

**Thank you!**

## How can I help?

RSpec::Wait is open source and contributions from the community are encouraged!
No contribution is too small.

See RSpec::Wait's [contribution guidelines](CONTRIBUTING.md) for more
information.
