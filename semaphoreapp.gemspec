# -*- encoding: utf-8 -*-
require File.expand_path('../lib/semaphoreapp/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alessandro Morandi"]
  gem.email         = ["webmaster@simbul.net"]
  gem.description   = %q{A client for the Semaphore API}
  gem.summary       = %q{A client for the Semaphore API}
  gem.homepage      = "http://github.com/Simbul/semaphoreapp"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "semaphoreapp"
  gem.require_paths = ["lib"]
  gem.version       = Semaphoreapp::VERSION

  gem.add_runtime_dependency 'json'

  gem.add_development_dependency 'awesome_print'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rspec', '~> 2'
end
