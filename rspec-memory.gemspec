# frozen_string_literal: true

require_relative 'lib/rspec/memory/version'

Gem::Specification.new do |spec|
  spec.name = 'rspec-memory'
  spec.version = RSpec::Memory::VERSION

  spec.summary = 'RSpec helpers for checking memory allocations.'
  spec.authors = ['Samuel Williams', 'Olle Jonsson', 'Cyril Roelandt', 'Daniel Leidert', 'Felix Yan']
  spec.license = 'MIT'

  spec.cert_chain  = ['release.cert']
  spec.signing_key = File.expand_path('~/.gem/release.pem')

  spec.homepage = 'https://github.com/socketry/rspec-memory'

  spec.files = Dir.glob(['{lib}/**/*', '*.md'], File::FNM_DOTMATCH, base: __dir__)

  spec.required_ruby_version = '>= 3.2.2'

  spec.add_dependency 'rspec', '~> 3.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'covered'
end
