# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2019-2023, by Samuel Williams.

source 'https://rubygems.org'

# Specify your gem's dependencies in rspec-memory.gemspec
gemspec

group :maintenance, optional: true do
	gem "bake-gem"
	gem "bake-modernize"
end

group :test do
	gem "bake-test"
	gem "bake-test-external"
	gem "guard-rspec", "~> 4.7"
end
