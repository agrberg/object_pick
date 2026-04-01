`Object#pick`
=============

[![CI](https://github.com/agrberg/object_pick/actions/workflows/ci.yml/badge.svg)](https://github.com/agrberg/object_pick/actions/workflows/ci.yml)
[![Gem Version](https://badge.fury.io/rb/object_pick.svg)](https://badge.fury.io/rb/object_pick)

`object_pick` extends Ruby's `Object` class with a `pick` method, allowing you to extract a hash of method results from any object.

```ruby
obj.pick(:foo, :bar)

# is equivalent to the more verbose

{ foo: obj.foo, bar: obj.bar }
```

### Example

Extracting properties from an object

```ruby
Person = Struct.new(:name, :age, :email)
person = Person.new('Alice', 30, 'alice@example.com')

person.pick(:name, :age)
  # => {name: "Alice", age: 30}
```

Errata
------

Similar to its counterparts, [`array_proc`](https://github.com/agrberg/array_proc) and [`string_proc`](https://github.com/agrberg/string_proc), I recommend caution using this in production code. It monkey-patches `Object`, which affects every object in the runtime. However, it can be a valuable tool for exploring and debugging objects in a REPL. For that reason, I often include it in my `Gemfile` with `require: false` ensuring that it won't be unintentionally used in code without explicitly requiring it via `require 'object_pick'`.

Installation
--------------------

Include it in your project's `Gemfile`:

```ruby
gem 'object_pick'
```

License
---------

MIT: https://mit-license.org/
