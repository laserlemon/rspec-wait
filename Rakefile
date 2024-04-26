require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

begin
  require "rubocop/rake_task"
rescue LoadError
  task default: [:spec]
else
  RuboCop::RakeTask.new(:rubocop)
  task default: [:rubocop, :spec]
end
