# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2019-2023, by Samuel Williams.

require_relative 'memory/matchers/limit_allocations'

RSpec.shared_context RSpec::Memory do
	include RSpec::Memory::Matchers
end
