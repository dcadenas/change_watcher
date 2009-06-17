# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{change_watcher}
  s.version = "0.1.0"
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Cadenas"]
  s.date = %q{2009-06-17}
  s.email = %q{dcadenas@gmail.com}
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
     "VERSION",
     "change_watcher.gemspec",
     "lib/change_watcher.rb",
     "lib/change_watcher/file_store.rb",
     "lib/change_watcher/store.rb",
     "test/change_watcher/file_store_test.rb",
     "test/change_watcher_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/dcadenas/change_watcher}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{TODO}
  s.test_files = [
    "test/change_watcher/file_store_test.rb",
     "test/change_watcher_test.rb",
     "test/test_helper.rb"
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
