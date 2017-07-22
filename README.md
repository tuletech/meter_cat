[![Build Status](https://travis-ci.org/schrodingersbox/meter_cat.svg?branch=master)](https://travis-ci.org/schrodingersbox/meter_cat)
[![Coverage Status](https://coveralls.io/repos/schrodingersbox/meter_cat/badge.png?branch=master)](https://coveralls.io/r/schrodingersbox/meter_cat?branch=master)
[![Code Climate](https://codeclimate.com/github/schrodingersbox/meter_cat.png)](https://codeclimate.com/github/schrodingersbox/meter_cat)
[![Dependency Status](https://gemnasium.com/schrodingersbox/meter_cat.png)](https://gemnasium.com/schrodingersbox/meter_cat)
[![Gem Version](https://badge.fury.io/rb/meter_cat.png)](http://badge.fury.io/rb/meter_cat)

# schrodingersbox/meter_cat README

This Rails engine makes monitoring the usage history of your Rails environment easier.
It provides meters, similar to the odometer in a car, which can be incremented
when significant actions happen in your app, and are recorded on a daily basis.

Meters are managed in RAM and periodically flushed to DB after a configurable amount of time,
when the calendar day rolls over, or when the process exits.

Some examples of useful meters would be number of users created, number of emails sent, or
other events particular to your application.  Even in cases where the equivalent value could be
determined with a count query, it can still be more efficient to look up a set of meter values,
rather than run a bunch of count queries.

## Getting Started

1. Add this to your `Gemfile` and `bundle install`

		gem 'meter_cat'

2. Add this to your `config/routes.rb`

		mount MeterCat::Engine => '/meter_cat'

3. Install and run migrations

        rake meter_cat:install:migrations
        rake db:migrate

4. Generate some random data

    rake meter_cat:random[my_test,0,100,365]

5. Restart your Rails server

6.  Visit http://yourapp/meter_cat in a browser for an HTML meter report

## Configuration

  All configuration should go in `config/initializers/meter_cat.rb`.

      MeterCat.configure do |config|

        config.layout = 'meters'
        config.expiration = 60

        config.ratio( :failed_to_create_ratio, :login_failed, :user_created )
        config.percentage( :failed_to_create_percentage, :login_failed, :user_created )
        config.sum( :failed_plus_create, [ :login_failed, :user_created ] )

        config.to = 'ops@schrodingersbox.com'
        config.from = 'ops@schrodingersbox.com'
        config.subject = "#{Rails.env.upcase} MeterCat Report"
        config.mail_days = 7

        config.authenticate_with do
          warden.authenticate! scope: :user
        end

        config.authorize_with do
          redirect_to main_app.root_path unless current_user.try(:admin?)
        end

      end

## How To

### Increment A Meter

The easiest way is to call `MeterCat.add`.

        MeterCat.add( :any_name_you_like )

You can also optionally pass a value and date.

        MeterCat.add( :any_name_you_like, value = 1, created_on = Date.today )

### Set A Meter

The easiest way is to call `MeterCat.set`.

        MeterCat.set( :any_name_you_like )

You can also optionally pass a value and date.

        MeterCat.set( :any_name_you_like, value = 1, created_on = Date.today )

This is useful where you want to record a single value for the day, such as from a daily cron job.

### Add Calculated Values

Calculated values (ratios, percentages, and sums) can be defined in `config/initializers/meter_cat.rb`

      MeterCat.configure do |config|
        config.ratio( :failed_to_create_ratio, :login_failed, :user_created )
        config.percentage( :failed_to_create_percentage, :login_failed, :user_created )
        config.sum( :failed_plus_create, [ :login_failed, :user_created ] )
      end

### Generate Development Data

`rake meter_cat:random[name, min, max, days]` can be used to generate random data for development.

The arguments are defined as follows:

 * name = String, Any string up to 64 characters long
 * min = Integer, Minimum generated value
 * max = Integer, Maximum generated value
 * days = Integer, Days prior to date to generate values for

e.g. The following command will generate data for `:my_test` with value between 0 and 100 for the last year.

        rake meter_cat:random[my_test,0,100,365]

### Configure Email Settings

Create or add to `config/initializers/meter_cat.rb`

    MeterCat.configure do |config|
      config.to = 'ops@schrodingersbox.com'
      config.from = 'ops@schrodingersbox.com'
      config.subject = "#{Rails.env.upcase} MeterCat Report"
    end

### Email A Meter Report

You can email a meter report using rake:

    rake meter_cat:mail

You can email a meter report in code:

    MeterCat.mail

### Require authentication

Create or add to `config/initializers/meter_cat.rb`

    MeterCat.configure do |config|
      config.authenticate_with do
        warden.authenticate! scope: :user
      end
    end

### Require authorization

Create or add to `config/initializers/meter_cat.rb`

    MeterCat.configure do |config|
      config.authorize_with do
        redirect_to main_app.root_path unless current_user.try(:admin?)
      end
    end

### Apply a custom layout

Create or add to `config/initializers/meter_cat.rb`

    MeterCat.configure do |config|
      config.layout = 'admin'
    end

### Get Started Developing

1.  `cp spec/dummy/config/passwords.yml.sample spec/dummy/config/passwords.yml`    
2.  `rake app:db:create app:db:migrate app:db:test:prepare`

## Reference

 * [Getting Started with Engines](http://edgeguides.rubyonrails.org/engines.html)
 * [Testing Rails Engines With Rspec](http://whilefalse.net/2012/01/25/testing-rails-engines-rspec/)
 * [How do I write a Rails 3.1 engine controller test in rspec?](http://stackoverflow.com/questions/5200654/how-do-i-write-a-rails-3-1-engine-controller-test-in-rspec)
 * [Best practice for specifying dependencies that cannot be put in gemspec?](https://groups.google.com/forum/?fromgroups=#!topic/ruby-bundler/U7FMRAl3nJE)
 * [Clarifying the Roles of the .gemspec and Gemfile](http://yehudakatz.com/2010/12/16/clarifying-the-roles-of-the-gemspec-and-gemfile/)
 * [The Semi-Isolated Rails Engine](http://bibwild.wordpress.com/2012/05/10/the-semi-isolated-rails-engine/)
 * [FactoryGirl](https://github.com/thoughtbot/factory_girl)
 * [Add Achievement Badges to Your Gem README](http://elgalu.github.io/2013/add-achievement-badges-to-your-gem-readme/)
 * [Publishing your gem](http://guides.rubygems.org/publishing/)

## History

 * Version 0.0.8 = Rails 4 compatible
 * Version 5.0.0 = Rails 5 compatible

