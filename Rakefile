require "bundler/gem_tasks"
require "rake/testtask"

task :default => [:test]

Rake::TestTask.new do |t|
  t.libs.push "lib"
  t.test_files = FileList['spec/*_spec.rb', 'spec/ci_in_a_can/*_spec.rb']
  t.verbose = true
end
