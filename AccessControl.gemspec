# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{AccessControl}
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Adam Hawkins"]
  s.date = %q{2009-07-11}
  s.description = %q{Simple role based authorization for rails}
  s.email = %q{Adman1965@gmail.com}
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    "AccessControl.gemspec",
     "MIT-LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION",
     "generators/access_control/USAGE",
     "generators/access_control/access_control_generator.rb",
     "generators/access_control/templates/migrate/create_access_control_models.rb",
     "init.rb",
     "install.rb",
     "lib/access_control.rb",
     "lib/access_control/common_methods.rb",
     "lib/access_control/controller_helper.rb",
     "lib/access_control/language.rb",
     "lib/access_control/role_extension.rb",
     "lib/access_control/user_extension.rb",
     "lib/app/models/permission.rb",
     "lib/app/models/role.rb",
     "spec/access_controlled_user_spec.rb",
     "spec/models/permission_spec.rb",
     "spec/models/role_spec.rb",
     "spec/spec_helper.rb",
     "spec/support/access_control_user.rb",
     "spec/support/authorizable.rb",
     "spec/support/schema.rb",
     "tasks/access_control_tasks.rake",
     "uninstall.rb"
  ]
  s.homepage = %q{http://github.com/Adman65/AccessControl}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{Simple role based authorization for rails}
  s.test_files = [
    "spec/access_controlled_user_spec.rb",
     "spec/models/permission_spec.rb",
     "spec/models/role_spec.rb",
     "spec/spec_helper.rb",
     "spec/support/access_control_user.rb",
     "spec/support/authorizable.rb",
     "spec/support/schema.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
