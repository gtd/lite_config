# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lite_config/version'

Gem::Specification.new do |spec|
  spec.name          = "lite_config"
  spec.version       = LiteConfig::VERSION
  spec.authors       = ["Gabe da Silveira"]
  spec.email         = ["gabe@websaviour.com"]
  spec.description   = %q{Lightweight configuration for your ruby app.  Reads Rails-style YAML files from your config directory.  Features include optional environment namespacing, local convention-based override files, and indifferent (symbol vs string) access.}
  spec.summary       = %q{Lightweight configuration for your ruby app}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", ">= 5.0.0"
  spec.add_development_dependency "debugger"
end
