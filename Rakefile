# encoding: utf-8
require 'rake'
require 'rubygems/package_task'
require 'gaku/testing/common_rake'


task :default => [:spec]

spec = eval(File.read('gaku_imex.gemspec'))

Gem::PackageTask.new(spec) do |p|
  p.gem_spec = spec
end

desc "Release to gemcutter"
task :release => :package do
  require 'rake/gemcutter'
  Rake::Gemcutter::Tasks.new(spec).define
  Rake::Task['gem:push'].invoke
end

desc "Generates a dummy app for testing"
task :test_app do
  ENV['LIB_NAME'] = 'gaku_imex'
  Rake::Task['common:test_app'].invoke
end