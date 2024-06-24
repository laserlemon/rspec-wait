# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed

- Fix support for non-block matchers that don't define `#supports_block_expectations?`

## [1.0.0] - 2024-05-31

Promoted version 1.0.0.rc1 to 1.0.0.

## [1.0.0.rc1] - 2024-04-25

### Added

- Support for Ruby versions 3.0 through 3.3
- Support for RSpec versions 3.6 through 3.13
- A `clone_wait_matcher` configuration to use a new matcher for every block call (default: `false`)
- A `lib/rspec-wait.rb` file allowing Bundler to auto-require

### Changed

- Added RuboCop for consistent code style
- Move CI from Travis to GitHub Actions
- Stop using Ruby's dangerous `Timeout` API.
  Only evaluate the timeout condition after successfully calling the matcher's block, never mid-call.

### Removed

- Support for all Ruby 2.x versions
- Support for all RSpec 2.x versions
- Support for RSpec versions 3.0 through 3.3
- RSpec::Wait.version (in favor of RSpec::Wait::VERSION)
- Passing an argument to wait_for or wait.for (must pass a block)
- RSpec::Wait::TimeoutError in favor of RSpec failure

## [0.0.10] - 2024-04-26

### Changed

- Added RuboCop for consistent code style

### Deprecated

- Passing an argument to wait_for or wait.for (should pass a block)

## [0.0.9] - 2016-07-11

### Added

- Support for RSpec 3.5

### Removed

- Support for Ruby versions 1.9 and 2.0
- Support for all RSpec 2.x versions

## [0.0.8] - 2015-11-14

### Added

- Support for RSpec 3.4

## [0.0.7] - 2015-06-16

### Added

- Support for RSpec 3.3

## [0.0.6] - 2015-06-12

### Fixed

- Fix the `to_not` alias in cases where the condition is not met

## [0.0.5] - 2015-01-04

### Added

- Support for RSpec 3.2

## [0.0.4] - 2014-12-18

### Added

- Make RSpec::Wait's timeout and delay values configurable
- The wait(3.seconds).for { something }.to(happen) syntax sugar

## [0.0.3] - 2014-10-29

### Added

- Support for RSpec 3.1

## [0.0.2] - 2014-06-11

### Added

- Allow `wait_for` to accept either a value or block target
- Ensure blocks are re-evaluated with each iteration

## [0.0.1] - 2014-04-19

### Added

- Initial release!

[unreleased]: https://github.com/laserlemon/rspec-wait/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/laserlemon/rspec-wait/compare/v1.0.0.rc1...v1.0.0
[1.0.0.rc1]: https://github.com/laserlemon/rspec-wait/compare/v0.0.9...v1.0.0.rc1
[0.0.10]: https://github.com/laserlemon/rspec-wait/compare/v0.0.9...v0.0.10
[0.0.9]: https://github.com/laserlemon/rspec-wait/compare/v0.0.8...v0.0.9
[0.0.8]: https://github.com/laserlemon/rspec-wait/compare/v0.0.7...v0.0.8
[0.0.7]: https://github.com/laserlemon/rspec-wait/compare/v0.0.6...v0.0.7
[0.0.6]: https://github.com/laserlemon/rspec-wait/compare/v0.0.5...v0.0.6
[0.0.5]: https://github.com/laserlemon/rspec-wait/compare/v0.0.4...v0.0.5
[0.0.4]: https://github.com/laserlemon/rspec-wait/compare/v0.0.3...v0.0.4
[0.0.3]: https://github.com/laserlemon/rspec-wait/compare/v0.0.2...v0.0.3
[0.0.2]: https://github.com/laserlemon/rspec-wait/compare/v0.0.1...v0.0.2
[0.0.1]: https://github.com/laserlemon/rspec-wait/commits/v0.0.1
