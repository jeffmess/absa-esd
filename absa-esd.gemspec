# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "absa-esd/version"

Gem::Specification.new do |s|
  s.name        = "absa-esd"
  s.version     = Absa::Esd::VERSION
  s.authors     = ["Jeffrey van Aswegen, Douglas Anderson"]
  s.email       = ["jeffmess@gmail.com, i.am.douglas.anderson@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A ruby interface to commumicate with the ABSA Electronic Statement Delivery platform.}
  s.description = %q{A ruby interface to commumicate with the ABSA Electronic Statement Delivery platform.}

  s.rubyforge_project = "absa-esd"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.executables   << "absa-esd"
  s.require_paths = ["lib"]
  
  s.add_dependency "activesupport"
  s.add_dependency "i18n"
  s.add_dependency "strata", "~> 0.0.1"
end
