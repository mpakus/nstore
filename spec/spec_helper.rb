# frozen_string_literal: true

require 'bundler/setup'
require 'active_record'
require 'nstore'

ENV['RAILS_ENV'] ||= 'test'

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

load File.dirname(__FILE__) + '/schema.rb'
require File.dirname(__FILE__) + '/models/dump.rb'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.after(:each) do
    # Clean up all our models
    Dump.delete_all
  end
end
