# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2019-2023, by Samuel Williams.

require_relative '../trace'

require 'rspec/expectations'

module RSpec
  module Memory
    module Matchers
      class LimitAllocations
        include RSpec::Matchers::Composable
        
        def initialize(allocations = {}, count: nil, size: nil)
          @count = count
          @size = size
          
          @allocations = {}
          @errors = []
          
          allocations.each do |klass, count|
            of(klass, count:)
          end
        end
        
        def supports_block_expectations?
          true
        end
        
        def of(klass, **limits)
          @allocations[klass] = limits
          
          self
        end
        
        private def check(value, limit)
          case limit
          when Range
            unless limit.include? value
              yield "expected within #{limit}"
            end
          when Integer
            unless value == limit
              yield "expected exactly #{limit}"
            end
          end
        end
        
        def matches?(given_proc)
          return true unless trace = Trace.capture(@allocations.keys, &given_proc)
          
          if @count or @size
            # If the spec specifies a total limit, we have a limit which we can enforce which takes all allocations into account:
            total = trace.total
            
            if @count
              check(total.count, @count) do |expected|
                @errors << "allocated #{total.count} instances, #{total.size} bytes, #{expected} instances"
              end
            end
            
            if @size
              check(total.size, @size) do |expected|
                @errors << "allocated #{total.count} instances, #{total.size} bytes, #{expected} bytes"
              end
            end
          else
            # Otherwise unspecified allocations are considered an error:
            trace.ignored.each do |klass, allocation|
              @errors << "allocated #{allocation.count} #{klass} instances, #{allocation.size} bytes, but it was not specified"
            end
          end
          
          trace.allocated.each do |klass, allocation|
            next unless acceptable = @allocations[klass]
            
            check(allocation.count, acceptable[:count]) do |expected|
              @errors << "allocated #{allocation.count} #{klass} instances, #{allocation.size} bytes, #{expected} instances"
            end
            
            check(allocation.size, acceptable[:size]) do |expected|
              @errors << "allocated #{allocation.count} #{klass} instances, #{allocation.size} bytes, #{expected} bytes"
            end
          end
          
          @errors.empty?
        end
        
        def failure_message
          "exceeded allocation limit: #{@errors.join(', ')}"
        end
      end
      
      if respond_to?(:ruby2_keywords, true)
        def limit_allocations(count: nil, size: nil, **allocations)
          LimitAllocations.new(allocations, count:, size:)
        end
      else
        def limit_allocations(*arguments)
          LimitAllocations.new(*arguments)
        end
      end
    end
  end
end
