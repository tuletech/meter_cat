$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'meter_cat/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'meter_cat'
  s.version     = MeterCat::VERSION
  s.licenses    = ['MIT']
  s.authors     = ['Rich Humphrey']
  s.email       = ['rich@schrodingersbox.com']
  s.homepage    = 'https://github.com/schrodingersbox/meter_cat'
  s.summary     = 'A Rails engine for monitoring system activities over time'
  s.description =<<-EOD
    This Rails engine makes monitoring the usage history of your Rails environment easier.
    It provides meters, similar to the odometer in a car, which can be incremented
    when significant actions happen in your app, and are recorded on a daily basis.
  EOD

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '~> 5.0', '>= 5.0.0'

  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'rails-controller-testing'
  s.add_development_dependency 'rspec-html-matchers'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'spec_cat'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'status_cat'
end
