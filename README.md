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

 * Search logic - ensure bookmarkable
    * Move search form from html to helper
    * Wire in name selection

 * CSV export - 2 buttons on form: Display or CSV

 * Calculated stats
 * Grouping stats - necessary with full search and bookmarking?

 * RSpec matchers for testing meter behavior

 * Email logic

 * Rake tasks - just mailer?

 * Optimize
   * Stress test with large (> 100k) data set
   * Memoize Meter.names

 * Cosmetics
    * Toggle table row backgrounds
    * Simplify dates - mm/dd/yy, or even drop year when all the same?

 * Added "Getting Started" and "How To" sections to this README
   * Configuration
   * rspec matchers
   * Randomly generating stats for dev
   * Setting up dev environment - cd spec/dummy && rake db:fixtures:load

 * Publish as gem