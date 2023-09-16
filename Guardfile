RSPEC_CONFIG = {
  cmd: 'bundle exec rspec',
  all_on_start: true,
  all_after_pass: true,
  halt_on_fail: true,
  results_file: '/tmp/.guard_rspec_results-rspec-memory'
}.freeze

guard :rspec, RSPEC_CONFIG do
  require "guard/rspec/dsl"
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
