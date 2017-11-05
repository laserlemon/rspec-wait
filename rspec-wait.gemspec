lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rspec/wait/version"

Gem::Specification.new do |spec|
  spec.name    = "rspec-wait"
  spec.version = RSpec::Wait.version

  spec.author = "Steve Richert"
  spec.email  = "steve.richert@gmail.com"

  spec.summary     = "Wait for conditions in RSpec"
  spec.description = "RSpec::Wait enables time-resilient expectations in your RSpec test suite."
  spec.homepage    = "https://github.com/laserlemon/rspec-wait"
  spec.license     = "MIT"

  spec.files      = `git ls-files -z`.split("\x0")
  spec.test_files = spec.files.grep(/^spec/)

  spec.add_dependency "rspec", ">= 3"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
