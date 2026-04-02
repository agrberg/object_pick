# frozen_string_literal: true

describe Object do
  describe '#pick' do
    it 'returns a hash mapping method names to their return values' do
      expect(42.pick(:even?, :to_s)).to eq(even?: true, to_s: '42')
    end

    context 'with a custom class' do
      let(:klass) do
        Class.new do
          attr_reader :foo

          def initialize(foo)
            @foo = foo
          end

          def bar = 21 * 2
        end
      end

      it 'works with all methods including attr_readers' do
        obj = klass.new('value')
        expect(obj.pick(:foo, :bar)).to eq(foo: 'value', bar: 42)
      end
    end

    it 'works with inherited methods' do
      expect(42.pick(:frozen?, :nil?)).to eq(frozen?: true, nil?: false)
    end

    it 'returns an empty hash with no arguments' do
      expect(42.pick).to eq({})
    end

    it 'raises NoMethodError for nonexistent methods' do
      expect { 42.pick(:nonexistent) }.to raise_error(NoMethodError)
    end

    context 'with private methods' do
      let(:klass) { Class.new { private def secret = 'hidden' } }

      it 'raises NoMethodError' do
        expect { klass.new.pick(:secret) }.to raise_error(NoMethodError)
      end
    end

    it 'works with a single method' do
      expect(42.pick(:even?)).to eq(even?: true)
    end

    it 'works with Struct instances' do
      person = Struct.new(:name, :age).new('Alice', 30)
      expect(person.pick(:name, :age)).to eq(name: 'Alice', age: 30)
    end

    it 'works with String' do
      expect('hello'.pick(:length, :upcase, :frozen?)).to eq(length: 5, upcase: 'HELLO', frozen?: true)
    end

    it 'works with Array' do
      expect([1, 2, 3].pick(:size, :empty?, :first)).to eq(size: 3, empty?: false, first: 1)
    end

    it 'works with Hash' do
      expect({ a: 1 }.pick(:size, :empty?, :keys)).to eq(size: 1, empty?: false, keys: [:a])
    end

    it 'works with OpenStruct' do
      require 'ostruct'
      os = OpenStruct.new(name: 'Alice', age: 30) # rubocop:disable Style/OpenStructUse
      expect(os.pick(:name, :age)).to eq(name: 'Alice', age: 30)
    end

    it 'works with Data instances' do
      person = Data.define(:name, :age).new(name: 'Alice', age: 30)
      expect(person.pick(:name, :age)).to eq(name: 'Alice', age: 30)
    end

    it 'works with Module' do
      expect(Kernel.pick(:name)).to eq(name: 'Kernel')
    end

    it 'works with Class' do
      expect(Integer.pick(:name, :superclass)).to eq(name: 'Integer', superclass: Numeric)
    end

    it 'works with nil' do
      expect(nil.pick(:nil?, :frozen?, :to_s)).to eq(nil?: true, frozen?: true, to_s: '')
    end

    it 'works with true' do
      expect(true.pick(:nil?, :to_s)).to eq(nil?: false, to_s: 'true')
    end

    it 'works with false' do
      expect(false.pick(:nil?, :to_s)).to eq(nil?: false, to_s: 'false')
    end
  end
end
