# -*- encoding: utf-8 -*-
require File.expand_path('../lib/prissy/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Paul Sadauskas"]
  gem.email         = ["psadauskas@gmail.com"]
  gem.description   = %q{Even prettier JSON console output}
  gem.summary       = %q{Nicely format JSON}
  gem.homepage      = "https://github.com/paul/prissy"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "prissy"
  gem.require_paths = ["lib"]
  gem.version       = Prissy::VERSION

  gem.add_development_dependency "rspec", "~> 2.11"

  gem.add_dependency "multi_json", "~> 1.3"

  gem.add_dependency "options",        "~> 2.3.0"
  gem.add_dependency "term-ansicolor", "~> 1.0.7"
  gem.add_dependency "ruby-terminfo",  "~> 0.1.1"
end
