# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2019-2023, by Samuel Williams.

source 'https://rubygems.org'

ruby '3.2.2'

# Specify your gem's dependencies in rspec-memory.gemspec
gemspec

group :maintenance, optional: true do
  gem 'bake-gem', '~> 0.4.0'
  gem 'bake-modernize', '~> 0.17.8'
end

group :development, :test do
  gem 'covered', '~> 0.25.0', require: false
  gem 'guard-rspec', '~> 4.7'
  gem 'guard-rubocop', '~> 1.5'
end

group :test do
  gem 'bake-test', '~> 0.2.0'
  gem 'bake-test-external', '~> 0.3.3'
end
