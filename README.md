# schrodingersbox/meter_cat README

This engine makes monitoring the usage history of your Rails environment easier.

## Getting Started

1. Add this to your `Gemfile`

		gem 'meter_cat', :git => 'https://github.com/schrodingersbox/meter_cat.git'

2. Add this to your `config/routes.rb`

		mount MeterCat::Engine => '/meter_cat'

3. Restart your Rails server

4.  Visit http://yourapp/meter_cat in a browser for an HTML meter report

## How To

### Increment A Meter

### Configure Email Settings

### Configure Cache Settings

### Generate Development Data



## Reference

 * [Getting Started with Engines](http://edgeguides.rubyonrails.org/engines.html)
 * [Testing Rails Engines With Rspec](http://whilefalse.net/2012/01/25/testing-rails-engines-rspec/)
 * [How do I write a Rails 3.1 engine controller test in rspec?](http://stackoverflow.com/questions/5200654/how-do-i-write-a-rails-3-1-engine-controller-test-in-rspec)
 * [Best practice for specifying dependencies that cannot be put in gemspec?](https://groups.google.com/forum/?fromgroups=#!topic/ruby-bundler/U7FMRAl3nJE)
 * [Clarifying the Roles of the .gemspec and Gemfile](http://yehudakatz.com/2010/12/16/clarifying-the-roles-of-the-gemspec-and-gemfile/)
 * [The Semi-Isolated Rails Engine](http://bibwild.wordpress.com/2012/05/10/the-semi-isolated-rails-engine/)
 * [FactoryGirl](https://github.com/thoughtbot/factory_girl)

##TODO

 * Add 'as needed'
    * Rake task to bump a meter with args
    * RSpec matchers for testing meter behavior

 * Optimize
   * Stress test with large (> 100k) data set

 * Cosmetics
   * Filter descriptions to match data in table

 * Added "Getting Started" and "How To" sections to this README
   * Configuration
   * Randomly generating stats for dev
   * Setting up dev environment - cd spec/dummy && rake db:fixtures:load

 * Publish as gem