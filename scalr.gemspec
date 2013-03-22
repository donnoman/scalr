# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require "scalr/version"

Gem::Specification.new do |s|
  s.name        = "scalr"
  s.version     = Scalr::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Matt Hodgson"]
  s.email       = ["mhodgson@redbeard-tech.com"]
  s.homepage    = "http://github.com/redbeard-tech/mongoid-sphinx"
  s.summary     = "A Scalr API wrapper gem"
  s.description = "Scalr is a cloud infrastructure management provider. This gem is for interfacing with the Scalr.net API to obtain information about your instances and farms."

  s.required_rubygems_version = ">= 1.3.7"

  s.add_dependency("activesupport", ">= 2")
  s.add_dependency("i18n", ">= 0.5.0")
  s.add_dependency("mechanize", "~> 2.5.0")

  s.files        = Dir.glob("lib/**/*") + %w(README.markdown)
  s.require_path = 'lib'
end
