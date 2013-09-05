# schrodingersbox/meter_cat README

This engine makes monitoring the usage history of your Rails environment easier.

## Reference

 * [Getting Started with Engines](http://edgeguides.rubyonrails.org/engines.html)
 * [Testing Rails Engines With Rspec](http://whilefalse.net/2012/01/25/testing-rails-engines-rspec/)
 * [How do I write a Rails 3.1 engine controller test in rspec?](http://stackoverflow.com/questions/5200654/how-do-i-write-a-rails-3-1-engine-controller-test-in-rspec)
 * [Best practice for specifying dependencies that cannot be put in gemspec?](https://groups.google.com/forum/?fromgroups=#!topic/ruby-bundler/U7FMRAl3nJE)
 * [Clarifying the Roles of the .gemspec and Gemfile](http://yehudakatz.com/2010/12/16/clarifying-the-roles-of-the-gemspec-and-gemfile/)
 * [The Semi-Isolated Rails Engine](http://bibwild.wordpress.com/2012/05/10/the-semi-isolated-rails-engine/)

##TODO

 * Implement & test Meter.expired?

 * Library level methods - flush, increment, config
 * Configuration
    * Min flush time
    * Move Meter constants to config

 * Add MeterCat::Cache.flush_all
 * At exit logic - highlander call? document for app developer?


 * View logic
 * Name, description, frequency from i18n YML

 * RSpec helpers for testing meter behavior

 * CSV export

 * Email logic

 * Added "Getting Started" and "How To" sections to this README
   * Configuration

 * Publish as gem