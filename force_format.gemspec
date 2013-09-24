# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'force_format/version'

Gem::Specification.new do |spec|
  spec.name          = "force_format"
  spec.version       = ForceFormat::VERSION
  spec.authors       = ["Marcus Geißler\n"]
  spec.email         = ["marcus3006@gmail.com"]
  spec.description   = %q{Define the formats your Rails application should respond to}
  spec.summary       = %q{Forcing the format Rails controllers should respond to}
  spec.homepage      = "https://github.com/marcusg/force_format"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'rails', '>= 3.2.0'
end
