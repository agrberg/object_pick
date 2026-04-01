# frozen_string_literal: true

describe Object do
  describe '#pick' do
    it 'returns a hash mapping method names to their return values' do
      expect(42.pick(:even?, :zero?)).to eq(even?: true, zero?: false)
    end

    context 'with a custom class' do
      let(:klass) do
        Class.new do
          attr_reader :foo, :bar

          def initialize(foo, bar)
            @foo = foo
            @bar = bar
          end
        end
      end

      it 'works with attr_readers' do
        obj = klass.new('value', 42)
        expect(obj.pick(:foo, :bar)).to eq(foo: 'value', bar: 42)
      end
    end

    context 'with instance methods' do
      let(:klass) do
        Class.new do
          def greeting = 'hello'
          def farewell = 'goodbye'
        end
      end

      it 'returns method results' do
        expect(klass.new.pick(:greeting, :farewell)).to eq(greeting: 'hello', farewell: 'goodbye')
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
  end
end
