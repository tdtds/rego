# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rego/version"

Gem::Specification.new do |s|
  s.name        = "rego_wcm"
  s.version     = REGO::VERSION
  s.authors     = ["TADA Tadashi"]
  s.email       = ["t@tdtds.jp"]
  s.homepage    = ""
  s.summary     = %q{A CMS generating static HTML by building blocks.}
  s.description = %q{}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
