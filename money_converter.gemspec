# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'money_converter/version'

Gem::Specification.new do |spec|
  spec.name          = "money_converter.gem"
  spec.version       = MoneyConverter::VERSION
  spec.authors       = ["Sebastian Oelke"]
  spec.email         = ["dev@soelke.de"]
  spec.summary       = "A converter for different currencies."
  spec.description   = "This gem takes a configuration for different currency rates
                        and let's you calculate with currencies."
  spec.homepage      = "https://github.com/baschtl/money_converter.gem"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake",    "~> 10.0"
  spec.add_development_dependency "rspec",   "~> 3.3"
end
