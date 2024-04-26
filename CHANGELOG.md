## 0.0.10 / 2024-04-26

* [DEPRECATION] Passing an argument to wait_for or wait.for (should pass a block)
* [ENHANCEMENT] Added RuboCop for consistent code style

## 0.0.9 / 2016-07-11

* [ENHANCEMENT] Remove support for Ruby versions 1.9 and 2.0
* [ENHANCEMENT] Remove support for all RSpec 2.x versions
* [ENHANCEMENT] Add support for RSpec 3.5

## 0.0.8 / 2015-11-14

* [ENHANCEMENT] Add support for RSpec 3.4

## 0.0.7 / 2015-06-16

* [ENHANCEMENT] Add support for RSpec 3.3

## 0.0.6 / 2015-06-12

* [BUGFIX] Fix the `to_not` alias in cases where the condition is not met

## 0.0.5 / 2015-01-04

* [ENHANCEMENT] Add support for RSpec 3.2

## 0.0.4 / 2014-12-18

* [FEATURE] Make RSpec::Wait's timeout and delay values configurable
* [FEATURE] Add the wait(3.seconds).for { something }.to(happen) syntax sugar

## 0.0.3 / 2014-10-29

* [ENHANCEMENT] Add support for RSpec 3.1

## 0.0.2 / 2014-06-11

* [ENHANCEMENT] Allow `wait_for` to accept either a value or block target
* [BUGFIX] Ensure blocks are re-evaluated with each iteration

## 0.0.1 / 2014-04-19

* Initial release!
