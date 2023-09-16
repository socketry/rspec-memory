# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2019-2023, by Samuel Williams.

source 'https://rubygems.org'

ruby '3.2.2'

# Specify your gem's dependencies in rspec-memory.gemspec
gemspec

group :maintenance, optional: true do
  gem 'bake-gem'
  gem 'bake-modernize'
end

group :test do
  gem 'bake-test'
  gem 'bake-test-external'
  gem 'guard-rspec', '~> 4.7'
  gem 'guard-rubocop', '~> 1.5'
end
