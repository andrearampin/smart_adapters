# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'smart_adapters/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name          = 'smart_adapters'
  spec.version       = SmartAdapters::VERSION
  spec.authors       = ['Andrea Rampin']
  spec.email         = ['andrea.rampin@gmail.com']
  spec.summary       = 'Keep your controllers DRY'
  spec.description   = 'Smart Adapters keep Rails controllers dry.'
  spec.homepage      = 'https://github.com/andrearampin/smart_adapters'
  spec.license       = 'GPL-3.0'

  spec.files = Dir['{app,config,db,lib}/**/*', 'LICENSE',
                   'Rakefile', 'README.md']

  spec.add_dependency 'rails', '~> 5.0'

  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rspec-rails'
end
