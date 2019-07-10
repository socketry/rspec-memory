# coding: utf-8
require_relative 'lib/rspec/memory/version'

Gem::Specification.new do |spec|
	spec.name          = "rspec-memory"
	spec.version       = RSpec::Memory::VERSION
	spec.authors       = ["Samuel Williams"]
	spec.email         = ["samuel.williams@oriontransfer.co.nz"]

	spec.summary       = "Matches for checking memory allocations."
	spec.homepage      = "https://github.com/socketry/rspec-memory"

	spec.files         = `git ls-files -z`.split("\x0").reject do |f|
		f.match(%r{^(test|spec|features)/})
	end
	
	spec.require_paths = ["lib"]
	
	spec.add_dependency "rspec", "~> 3.0"
	
	spec.add_development_dependency "covered"
	spec.add_development_dependency "bundler"
	spec.add_development_dependency "rake", "~> 10.0"
end
