ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

# gem 'minitest-reporters' setup
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize_setup do |worker|
    puts "Loading seeds..."
    load "#{Rails.root}/db/seeds.rb"
    puts "Seeds loaded!"
  end

  # workers: 2以上の場合は並列実行される
  # number_of_processors: dockerのコア数
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
end
