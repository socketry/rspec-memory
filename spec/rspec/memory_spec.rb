# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2019-2023, by Samuel Williams.

require 'rspec/memory'
require 'timeout'

RSpec.describe RSpec::Memory do
  include_context RSpec::Memory

  it 'should execute code in block' do
    string = nil

    expect do
      string = String.new
    end.to limit_allocations(String => 1)

    expect(string).to_not be_nil
  end

  context 'on supported platform', if: RSpec::Memory::Trace.supported? do
    it 'should not exceed specified count limit' do
      expect do
        2.times { String.new }
      end.to limit_allocations(String => 2)

      expect do
        2.times { String.new }
      end.to limit_allocations.of(String, count: 2)
    end

    it 'should fail if there are untracked allocations' do
      expect do
        expect do
          []
        end.to limit_allocations
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError, /it was not specified/)
    end

    if RSpec::Memory::Trace.supported?
      it 'should exceed specified count limit' do
        expect do
          expect do
            6.times { String.new }
          end.to limit_allocations(String => 4)
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError, /expected exactly 4 instances/)
      end
    end

    it 'should be within specified count range' do
      expect do
        2.times { String.new }
      end.to limit_allocations(String => 1..3)

      expect do
        2.times { String.new }
      end.to limit_allocations.of(String, count: 1..3)
    end

    it 'should exceed specified count range' do
      expect do
        expect do
          6.times { String.new }
        end.to limit_allocations(String => 1..3)
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError, /expected within 1\.\.3 instances/)
    end

    it 'should not exceed specified size limit' do
      expect do
        'a' * 100_000
      end.to limit_allocations.of(String, size: 100_001)
    end

    it 'should exceed specified size limit' do
      expect do
        expect do
          'a' * 120_000
        end.to limit_allocations(size: 100_000)
      end.to raise_error(RSpec::Expectations::ExpectationNotMetError, /expected exactly 100000 bytes/)
    end

    it 'allows constants as strings' do
      expect do
        'a' * 100_000
      end.to limit_allocations.of('String', size: 100_001)
    end

    it 'allows using private constants as strings' do
      expect do
        Timeout.timeout(1) do
          String.new
        end
      end.to limit_allocations(
        Thread::Mutex => { count: 1, size: 32 },
        String => { count: 1, size: 0 },
        Timeout::Error => { count: 1, size: 48 },
        Array => { count: 2, size: 0 },
        Proc => { count: 3, size: 120 },
        Hash => { count: 1, size: 128 },
        Thread => { count: 1, size: 360 },
        'Timeout::Request' => { count: 1, size: 40 }
      )
    end
  end
end
