# -*- encoding: utf-8 -*-
# stub: rails3-jquery-autocomplete 1.0.14 ruby lib

Gem::Specification.new do |s|
  s.name = "rails3-jquery-autocomplete"
  s.version = "1.0.14"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["David Padilla", "Joiey Seeley", "Manu S Ajith"]
  s.date = "2014-03-31"
  s.description = "Use jQuery's autocomplete plugin with Rails 3."
  s.email = "david.padilla@crowdint.com joiey.seeley@gmail.com neo@codingarena.in"
  s.homepage = "http://github.com/crowdint/rails3-jquery-autocomplete"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.2"
  s.summary = "Use jQuery's autocomplete plugin with Rails 3."

  s.installed_by_version = "2.4.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3.0"])
      s.add_development_dependency(%q<sqlite3-ruby>, [">= 0"])
      s.add_development_dependency(%q<mongoid>, [">= 2.0.0"])
      s.add_development_dependency(%q<mongo_mapper>, [">= 0.9"])
      s.add_development_dependency(%q<mongo>, ["~> 1.6.2"])
      s.add_development_dependency(%q<bson_ext>, ["~> 1.6.2"])
      s.add_development_dependency(%q<guard>, [">= 0"])
      s.add_development_dependency(%q<guard-test>, [">= 0"])
      s.add_development_dependency(%q<test-unit>, ["~> 2.2.0"])
      s.add_development_dependency(%q<shoulda>, ["~> 3.0.1"])
      s.add_development_dependency(%q<uglifier>, [">= 0"])
      s.add_development_dependency(%q<rr>, [">= 0"])
      s.add_development_dependency(%q<simple_form>, ["~> 1.5"])
    else
      s.add_dependency(%q<rails>, [">= 3.0"])
      s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
      s.add_dependency(%q<mongoid>, [">= 2.0.0"])
      s.add_dependency(%q<mongo_mapper>, [">= 0.9"])
      s.add_dependency(%q<mongo>, ["~> 1.6.2"])
      s.add_dependency(%q<bson_ext>, ["~> 1.6.2"])
      s.add_dependency(%q<guard>, [">= 0"])
      s.add_dependency(%q<guard-test>, [">= 0"])
      s.add_dependency(%q<test-unit>, ["~> 2.2.0"])
      s.add_dependency(%q<shoulda>, ["~> 3.0.1"])
      s.add_dependency(%q<uglifier>, [">= 0"])
      s.add_dependency(%q<rr>, [">= 0"])
      s.add_dependency(%q<simple_form>, ["~> 1.5"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.0"])
    s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
    s.add_dependency(%q<mongoid>, [">= 2.0.0"])
    s.add_dependency(%q<mongo_mapper>, [">= 0.9"])
    s.add_dependency(%q<mongo>, ["~> 1.6.2"])
    s.add_dependency(%q<bson_ext>, ["~> 1.6.2"])
    s.add_dependency(%q<guard>, [">= 0"])
    s.add_dependency(%q<guard-test>, [">= 0"])
    s.add_dependency(%q<test-unit>, ["~> 2.2.0"])
    s.add_dependency(%q<shoulda>, ["~> 3.0.1"])
    s.add_dependency(%q<uglifier>, [">= 0"])
    s.add_dependency(%q<rr>, [">= 0"])
    s.add_dependency(%q<simple_form>, ["~> 1.5"])
  end
end
