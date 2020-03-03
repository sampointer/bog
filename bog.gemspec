# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bog/version'

Gem::Specification.new do |spec|
  spec.name          = "bog"
  spec.version       = Bog::VERSION
  spec.authors       = ["sam"]
  spec.email         = ["sam.pointer@opsunit.com"]
  spec.summary       = %q{A tool for managing cloud API and configuration management credentials.}
  spec.description   = %q{A tool for managing cloud API and configuration management credentials. rbenv for dotfiles.}
  spec.homepage      = "https://github.com/opsunit/bog"
  spec.license       = "GPL3"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 1.9.3"

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "slop", "~> 3.4"
  spec.add_dependency "require_all", "~> 1.3"
end
