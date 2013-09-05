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

 * Accumulator logic
    * :name => Meter

 * Flushing logic
    * If !date,flush old accumulated value, remember new one
    * How to determine non-date change flush?  Time based?  Heuristic?

 * Library level methods - flush, increment, config
 * Configuration
    * Min flush time
    * Move Meter constants to config

 * At exit logic - highlander call? document for app developer?

 * View logic
 * Name, description, frequency from i18n YML

 * CSV export

 * Email logic

 * Added "Getting Started" and "How To" sections to this README

 * Publish as gem