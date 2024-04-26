# frozen_string_literal: true

require_relative "lib/rspec/wait/version"

Gem::Specification.new do |spec|
  spec.name = "rspec-wait"
  spec.summary = "Wait for conditions in RSpec"
  spec.description = "RSpec::Wait enables time-resilient expectations in your RSpec test suite."
  spec.version = RSpec::Wait::VERSION

  spec.author = "Steve Richert"
  spec.email = "steve.richert@hey.com"
  spec.license = "MIT"
  spec.homepage = "https://github.com/laserlemon/rspec-wait"

  spec.metadata = {
    "allowed_push_host" => "https://rubygems.org",
    "bug_tracker_uri" => "https://github.com/laserlemon/rspec-wait/issues",
    "funding_uri" => "https://github.com/sponsors/laserlemon",
    "homepage_uri" => "https://github.com/laserlemon/rspec-wait",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/laserlemon/rspec-wait",
  }

  spec.required_ruby_version = ">= 2.2"
  spec.add_dependency "rspec", ">= 3.0"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"

  spec.files = Dir.glob([
    "rspec-wait.gemspec",
    "lib/**/*.rb",
    "LICENSE.txt",
  ])

  spec.extra_rdoc_files = ["README.md"]

  spec.post_install_message = <<-MSG
[rspec-wait] RSpec::Wait 1.0 has arrived! Please upgrade for the latest and greatest.
[rspec-wait] See what's changed here: https://github.com/laserlemon/rspec-wait/blob/-/CHANGELOG.md
  MSG
end
