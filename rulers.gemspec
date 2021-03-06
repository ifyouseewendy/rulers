# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rulers/version'

Gem::Specification.new do |spec|
  spec.name          = "rulers"
  spec.version       = Rulers::VERSION
  spec.authors       = ["wendi"]
  spec.email         = ["ifyouseewendy@gmail.com"]
  spec.summary       = %q{A Rack-based Web Framework}
  spec.description   = %q{A Rack-based Web Framework,
                          but with extra awesome.}
  spec.homepage      = "http://ifyouseewendy.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", '~> 10.3'

  spec.add_runtime_dependency "rack", '~> 1.5'
  spec.add_runtime_dependency "erubis", '~> 2.7'
  spec.add_runtime_dependency "multi_json", '~> 1.10'
  spec.add_runtime_dependency "pry-byebug", '~> 1.3.2'
  spec.add_runtime_dependency "sqlite3", '~> 1.3.8'
  spec.add_development_dependency "rack-test", '~> 0.6'
  spec.add_development_dependency "test-unit", '~> 3.0'

end
