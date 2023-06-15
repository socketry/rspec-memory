# RSpec::Memory

Make assertions about memory usage.

[![Development Status](https://github.com/socketry/rspec-memory/workflows/Test/badge.svg)](https://github.com/socketry/rspec-memory/actions?workflow=Test)

## Installation

Add this line to your application's Gemfile:

``` ruby
gem 'rspec-memory'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-memory

Finally, add this require statement to the top of `spec/spec_helper.rb`

``` ruby
require 'rspec/memory'
```

## Usage

Allocating large amounts of objects can lead to memory problems. `RSpec::Memory` adds a `limit_allocations` matcher, which tracks the number of allocations and memory size for each object type and allows you to specify expected limits.

``` ruby
RSpec.describe "memory allocations" do
	include_context RSpec::Memory
	
	it "limits allocation counts" do
		expect do
			6.times{String.new}
		end.to limit_allocations(String => 10) # 10 strings can be allocated
	end
	
	it "limits allocation counts (hash)" do
		expect do
			6.times{String.new}
		end.to limit_allocations(String => {count: 10}) # 10 strings can be allocated
	end
	
	it "limits allocation size" do
		expect do
			6.times{String.new("foo")}
		end.to limit_allocations(String => {size: 1024}) # 1 KB of strings can be allocated
	end
end
```

## Contributing

We welcome contributions to this project.

1.  Fork it.
2.  Create your feature branch (`git checkout -b my-new-feature`).
3.  Commit your changes (`git commit -am 'Add some feature'`).
4.  Push to the branch (`git push origin my-new-feature`).
5.  Create new Pull Request.
