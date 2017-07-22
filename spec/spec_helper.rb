# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]
)

SimpleCov.start 'rails' do
  add_filter '/vendor/'
  add_filter '/spec/'
end

require File.expand_path('../dummy/config/environment', __FILE__)
require 'rspec/rails'
require 'rails-controller-testing'
require 'rspec-html-matchers'
require 'factory_girl_rails'
require 'spec_cat'

ENGINE_ROOT = File.join(File.dirname(__FILE__), '..')

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(ENGINE_ROOT, 'spec/support/**/*.rb')].each {|f| require f }

RSpec.configure do |config|

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  [:controller, :view, :request].each do |type|
    config.include ::Rails::Controller::Testing::TestProcess, type: type
    config.include ::Rails::Controller::Testing::TemplateAssertions, type: type
    config.include ::Rails::Controller::Testing::Integration, type: type
  end

  config.include RSpecHtmlMatchers
end

def setup_meters
  MeterCat::Meter.delete_all
  @user_created_1 = FactoryGirl.create( :user_created_1 )
  @user_created_2 = FactoryGirl.create( :user_created_2 )
  @user_created_3 = FactoryGirl.create( :user_created_3 )
  @login_failed_3 = FactoryGirl.create( :login_failed_3 )

  @start = @user_created_1.created_on
  @stop = @user_created_3.created_on
  @range = @start .. @stop

  @names = [ @user_created_1.name.to_sym ]

  @conditions = { :created_on => @range, :name => @names }
end
