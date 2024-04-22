# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.0.9] - 2016-07-11

### Added

- Support for RSpec 3.5

### Removed

- Support for Ruby versions 1.9 and 2.0

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

[unreleased]: https://github.com/laserlemon/rspec-wait/compare/v0.0.9...HEAD
[0.0.9]: https://github.com/laserlemon/rspec-wait/compare/v0.0.8...v0.0.9
[0.0.8]: https://github.com/laserlemon/rspec-wait/compare/v0.0.7...v0.0.8
[0.0.7]: https://github.com/laserlemon/rspec-wait/compare/v0.0.6...v0.0.7
[0.0.6]: https://github.com/laserlemon/rspec-wait/compare/v0.0.5...v0.0.6
[0.0.5]: https://github.com/laserlemon/rspec-wait/compare/v0.0.4...v0.0.5
[0.0.4]: https://github.com/laserlemon/rspec-wait/compare/v0.0.3...v0.0.4
[0.0.3]: https://github.com/laserlemon/rspec-wait/compare/v0.0.2...v0.0.3
[0.0.2]: https://github.com/laserlemon/rspec-wait/compare/v0.0.1...v0.0.2
[0.0.1]: https://github.com/laserlemon/rspec-wait/commits/v0.0.1
