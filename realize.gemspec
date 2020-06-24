# frozen_string_literal: true

require './lib/realize/version'

Gem::Specification.new do |s|
  s.name        = 'realize'
  s.version     = Realize::VERSION
  s.summary     = 'Configurable Data Transformation Pipeline'

  s.description = <<-DESCRIPTION
    Derive and transform a value using a configuration-first pipeline.
  DESCRIPTION

  s.authors     = ['Matthew Ruggio', 'Dan Dewar']
  s.email       = ['mruggio@bluemarblepayroll.com', 'ddewar@bluemarblepayroll.com']
  s.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.bindir      = 'exe'
  s.executables = []
  s.homepage    = 'https://github.com/bluemarblepayroll/realize'
  s.license     = 'MIT'
  s.metadata    = {
    'bug_tracker_uri' => 'https://github.com/bluemarblepayroll/realize/issues',
    'changelog_uri' => 'https://github.com/bluemarblepayroll/realize/blob/master/CHANGELOG.md',
    'documentation_uri' => 'https://www.rubydoc.info/gems/realize',
    'homepage_uri' => s.homepage,
    'source_code_uri' => s.homepage
  }

  s.required_ruby_version = '>= 2.5'

  s.add_dependency('acts_as_hashable', '~>1', '>=1.2.0')
  s.add_dependency('objectable', '~>1')

  s.add_development_dependency('guard-rspec', '~>4.7')
  s.add_development_dependency('pry', '~>0')
  s.add_development_dependency('rake', '~> 13')
  s.add_development_dependency('rspec')
  s.add_development_dependency('rubocop', '~>0.79.0')
  s.add_development_dependency('simplecov', '~>0.17.0')
  s.add_development_dependency('simplecov-console', '~>0.6.0')
end
