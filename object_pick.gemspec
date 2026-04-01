# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'object_pick'
  s.version     = '1.0.0'
  s.summary     = 'Extract a hash of method results from any object.'
  s.description = 'Adds `Object#pick`.'
  s.authors     = ['Aaron Rosenberg']
  s.email       = 'aarongrosenberg@gmail.com'
  s.files       = ['lib/object_pick.rb']
  s.homepage    = 'https://github.com/agrberg/object_pick'
  s.licenses    = ['MIT']
  s.metadata['rubygems_mfa_required'] = 'true'
  s.metadata['source_code_uri'] = 'https://github.com/agrberg/object_pick'
  s.metadata['bug_tracker_uri'] = 'https://github.com/agrberg/object_pick/issues'

  s.required_ruby_version = '>= 3.3'
end
