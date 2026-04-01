# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

`object_pick` is a Ruby gem that adds a `pick` method to `Object`, enabling extraction of a hash of method results from any object (e.g., `obj.pick(:foo, :bar) #=> {foo: obj.foo, bar: obj.bar}`).

## Commands

- **Install dependencies:** `bundle install`
- **Run all checks (tests + lint):** `bundle exec rake`
- **Run tests:** `bundle exec rspec`
- **Run a single test file:** `bundle exec rspec spec/object_pick_spec.rb`
- **Run a single test by line:** `bundle exec rspec spec/object_pick_spec.rb:LINE`
- **Lint:** `bundle exec rubocop`
- **Lint with autofix:** `bundle exec rubocop -A`
- **Coverage report:** `bundle exec rake coverage`

## Architecture

The entire gem is a single file (`lib/object_pick.rb`) that monkey-patches `Object#pick`. It returns a hash mapping method names to their return values using `public_send`. Tests are in `spec/object_pick_spec.rb` using RSpec.

## Linting

RuboCop is configured (`.rubocop.yml`) with plugins: `rubocop-performance`, `rubocop-rake`, `rubocop-rspec`. All new cops are enabled by default.
