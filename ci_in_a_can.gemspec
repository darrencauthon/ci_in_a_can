# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ci_in_a_can/version'

Gem::Specification.new do |spec|
  spec.name          = "ci_in_a_can"
  spec.version       = CiInACan::VERSION
  spec.authors       = ["Darren Cauthon"]
  spec.email         = ["darren@cauthon.com"]
  spec.description   = %q{Fast CI. Still a WIP.}
  spec.summary       = %q{Fast CI. Still a WIP.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "contrast"
  spec.add_development_dependency "timecop"

  spec.add_runtime_dependency "rake"
  spec.add_runtime_dependency "sinatra"
  spec.add_runtime_dependency "json"
  spec.add_runtime_dependency "uuid"
  spec.add_runtime_dependency "listen"
  spec.add_runtime_dependency "octokit"
  spec.add_runtime_dependency "daemons"
  spec.add_runtime_dependency "subtle"
  spec.add_runtime_dependency "systemu"
end
