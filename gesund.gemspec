# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gesund/version'

Gem::Specification.new do |spec|
  spec.name          = "gesund"
  spec.version       = Gesund::VERSION
  spec.authors       = ["Evgeny Zislis"]
  spec.email         = ["evgeny@devops.co.il"]
  spec.description   = %q{Gesund is a simple health checker.}
  spec.summary       = %q{Health checker for services and state.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency "rack"
  spec.add_runtime_dependency "thor"
end
