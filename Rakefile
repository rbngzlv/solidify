begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

load 'rails/tasks/statistics.rake'

Bundler::GemHelper.install_tasks

require 'rspec/core'
require 'rspec/core/rake_task'
require 'spree/testing_support/common_rake'

require 'solidus_core'

desc 'Run all specs in spec directory (excluding plugin specs)'
RSpec::Core::RakeTask.new

task :default do
  if Dir['spec/dummy'].empty?
    Rake::Task[:test_app].invoke
    Dir.chdir('../../')
  end
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
  Rake::Task['rubocop:auto_correct'].invoke
  Rake::Task[:spec].invoke
end

desc 'Generates a dummy app for testing'
task :test_app do
  ENV['LIB_NAME'] = 'solidify'
  Rake::Task['common:test_app'].invoke('Spree::User')

  # we can not run this as a Rake::Task because it depends on environment
  # and environment is not ready from the just created dummy app for some reason
  # rubocop:disable Metric/LineLength
  sh 'bundle exec rake solidify:themes:seed_default_theme RAILS_ENV=test AWS_S3_BUCKET_NAME=solidify'
  # rubocop:enable Metric/LineLength
  sh 'bundle exec rake solidify:themes:download_all_themes RAILS_ENV=test'
end
