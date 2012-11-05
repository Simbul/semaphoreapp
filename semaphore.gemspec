# -*- encoding: utf-8 -*-
require File.expand_path('../lib/semaphore/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alessandro Morandi"]
  gem.email         = ["webmaster@simbul.net"]
  gem.description   = %q{TODO: A client for the Semaphore API}
  gem.summary       = %q{TODO: A client for the Semaphore API}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "semaphore"
  gem.require_paths = ["lib"]
  gem.version       = Semaphore::VERSION

  gem.add_runtime_dependency 'json'

  gem.add_development_dependency 'awesome_print'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'pry-debugger'
end
