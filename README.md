# RSpec::Memory

Make assertions about memory usage.

[![Build Status](https://travis-ci.com/socketry/rspec-memory.svg?branch=master)](https://travis-ci.com/socketry/rspec-memory)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-memory'
```

And then execute:

	$ bundle

Or install it yourself as:

	$ gem install rspec-memory
	
Finally, add this require statement to the top of `spec/spec_helper.rb`

```ruby
require 'rspec/memory'
```

## Usage

Allocating large amounts of objects can lead to memery problems. `RSpec::Memory` adds a `limit_allocations` matcher, which tracks the number of allocations and memory size for each object type and allows you to specify expected limits.

```ruby
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

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Released under the MIT license.

Copyright, 2017, by [Samuel G. D. Williams](http://www.codeotaku.com/samuel-williams).

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
