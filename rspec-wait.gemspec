# encoding: utf-8

Gem::Specification.new do |spec|
  spec.name    = "rspec-wait"
  spec.version = "0.0.7"

  spec.author      = "Steve Richert"
  spec.email       = "steve.richert@gmail.com"
  spec.summary     = "Wait for conditions in RSpec"
  spec.description = spec.summary
  spec.homepage    = "https://github.com/laserlemon/rspec-wait"
  spec.license     = "MIT"

  spec.files      = `git ls-files -z`.split("\x0")
  spec.test_files = spec.files.grep(/^spec/)

  spec.add_dependency "rspec", ">= 2.11", "< 3.4"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.4"
end
