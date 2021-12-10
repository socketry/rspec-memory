source 'https://rubygems.org'

# Specify your gem's dependencies in rspec-memory.gemspec
gemspec

group :maintenance, optional: true do
	gem "bake-gem"
	gem "bake-modernize"
end
