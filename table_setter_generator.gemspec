# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{table_setter_generator}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jeff Larson"]
  s.date = %q{2010-03-09}
  s.description = %q{Generate a hackable version of TableSetter}
  s.email = %q{jeff.larson@propublica.org}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "USAGE",
     "VERSION",
     "lib/table_setter_generator.rb",
     "table_setter_generator.gemspec",
     "table_setter_generator.rb",
     "templates/routes.rb",
     "templates/table.rb",
     "templates/table_controller.rb",
     "templates/ts/config.ru",
     "templates/ts/public/favicon.ico",
     "templates/ts/public/images/th_arrow_asc.gif",
     "templates/ts/public/images/th_arrow_desc.gif",
     "templates/ts/public/javascripts/application.js",
     "templates/ts/public/javascripts/jquery.tablesorter.js",
     "templates/ts/public/javascripts/jquery.tablesorter.multipagefilter.js",
     "templates/ts/public/javascripts/jquery.tablesorter.pager.js",
     "templates/ts/public/stylesheets/stylesheet.css",
     "templates/ts/tables/example.yml",
     "templates/ts/tables/example_faceted.yml",
     "templates/ts/tables/example_formatted.csv",
     "templates/ts/tables/example_formatted.yml",
     "templates/ts/tables/example_local.csv",
     "templates/ts/tables/example_local.yml",
     "templates/ts/views/404.erb",
     "templates/ts/views/500.erb",
     "templates/ts/views/index.erb",
     "templates/ts/views/layout.erb",
     "templates/ts/views/table.erb"
  ]
  s.homepage = %q{http://github.com/propublica/table-setter-generator}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A Rails Generator for TableSetter}
  s.test_files = [
    "test/app/controllers/application_controller.rb",
     "test/app/helpers/application_helper.rb",
     "test/config/boot.rb",
     "test/config/environment.rb",
     "test/config/environments/development.rb",
     "test/config/environments/production.rb",
     "test/config/environments/test.rb",
     "test/config/initializers/backtrace_silencers.rb",
     "test/config/initializers/inflections.rb",
     "test/config/initializers/mime_types.rb",
     "test/config/initializers/new_rails_defaults.rb",
     "test/config/initializers/session_store.rb",
     "test/config/routes.rb",
     "test/db/seeds.rb",
     "test/test/performance/browsing_test.rb",
     "test/test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<table_setter>, [">= 0.1.2"])
      s.add_runtime_dependency(%q<rails>, [">= 2.3.5"])
    else
      s.add_dependency(%q<table_setter>, [">= 0.1.2"])
      s.add_dependency(%q<rails>, [">= 2.3.5"])
    end
  else
    s.add_dependency(%q<table_setter>, [">= 0.1.2"])
    s.add_dependency(%q<rails>, [">= 2.3.5"])
  end
end

