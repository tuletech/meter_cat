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

  s.add_dependency 'rails', '~> 4.0', '>= 4.0.0'

  s.add_development_dependency 'sqlite3', '~> 1.3', '>= 1.3.8'
  s.add_development_dependency 'rspec', '~> 2.14', '>= 2.14.0'
  s.add_development_dependency 'rspec-rails', '~> 2.14', '>= 2.14.0'
  s.add_development_dependency 'webrat', '~> 0.7', '>= 0.7.3'
  s.add_development_dependency 'factory_girl_rails', '~> 4.0'
end
