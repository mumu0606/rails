# -*- encoding: utf-8 -*-
# stub: bootstrap3-rails 3.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "bootstrap3-rails"
  s.version = "3.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Benjamin Canac"]
  s.date = "2014-07-10"
  s.description = "Add Bootstrap v3.2.0 to your rails app. See https://github.com/twbs/bootstrap/ for more information about Bootstrap v3.0.0 RC1."
  s.email = ["canacb1@gmail.com"]
  s.homepage = "https://github.com/benjamincanac/bootstrap3-rails"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.2"
  s.summary = "Add Bootstrap v3.2.0 to your rails app."

  s.installed_by_version = "2.4.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 4.0.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 4.0.0"])
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 4.0.0"])
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
