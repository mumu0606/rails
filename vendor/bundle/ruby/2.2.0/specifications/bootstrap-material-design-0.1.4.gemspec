# -*- encoding: utf-8 -*-
# stub: bootstrap-material-design 0.1.4 ruby lib

Gem::Specification.new do |s|
  s.name = "bootstrap-material-design"
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Paul King"]
  s.date = "2014-11-25"
  s.email = "freedomlijinfa@gmail.com"
  s.homepage = "https://github.com/Aufree/bootstrap-material-design"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.2"
  s.summary = "Material Design for Bootstrap"

  s.installed_by_version = "2.4.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bootstrap-sass>, ["~> 3.0"])
    else
      s.add_dependency(%q<bootstrap-sass>, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<bootstrap-sass>, ["~> 3.0"])
  end
end
