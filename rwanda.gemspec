# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rwanda/version'

Gem::Specification.new do |spec|
  spec.name          = "rwanda"
  spec.version       = Rwanda::VERSION
  spec.authors       = ["Dan Hetherington"]
  spec.email         = ["dan.hetherington@gmail.com"]
  spec.summary       = %q{Access information about geographical divisions in Rwanda.}
  #spec.description   = %q{}
  spec.homepage      = "http://www.minicom.gov.rw/"
  spec.license       = "GNU General Public License version 3.0 (GPL-3.0)"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry", "~> 0.10.1"
  spec.add_development_dependency "coveralls"
  
  spec.add_runtime_dependency "fuzzy_match", "~> 2.1.0"
end
