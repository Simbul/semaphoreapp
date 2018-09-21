$:.unshift File.realpath File.join(File.dirname(__FILE__), '..', 'lib')

require 'semaphoreapp'

def json_fixture(name)
  File.read File.join(File.dirname(__FILE__), 'fixtures', "#{name.to_s}.json")
end

def fixture(name)
  JSON.parse(json_fixture(name))
end

# See: http://stackoverflow.com/a/7364289/551557
RSpec.configure do |config|
  # Use color in STDOUT
  config.color = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate
end
