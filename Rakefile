# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

default_tasks =
  begin
    require "rubocop/rake_task"
    RuboCop::RakeTask.new(:rubocop)

    [:rubocop, :spec]
  rescue LoadError
    [:spec]
  end

task default: default_tasks
