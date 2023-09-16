# frozen_string_literal: true

RSPEC_CONFIG = {
  cmd: 'bundle exec rspec',
  all_on_start: true,
  all_after_pass: true,
  halt_on_fail: true,
  results_file: '/tmp/.guard_rspec_results-rspec-memory'
}.freeze

guard :rspec, RSPEC_CONFIG do
  require 'guard/rspec/dsl'
  dsl = Guard::RSpec::Dsl.new(self)

  # Feel free to open issues for suggestions and improvements

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)
end

RUBOCOP_CONFIG = {
  cli: '--display-cop-names --parallel',
  all_on_start: true,
  halt_on_fail: true
}.freeze

guard :rubocop, RUBOCOP_CONFIG do
  watch(/.+\.rb$/)
  watch(%r{(?:.+/)?\.rubocop(?:_todo)?\.yml$}) { |m| ::File.dirname(m[0]) }
  watch('Guardfile')
end
