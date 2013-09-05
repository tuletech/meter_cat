require 'meter_cat/engine'
require 'meter_cat/cache'
require 'meter_cat/config'

module MeterCat

  @@cache = nil

  def add( name, value = 1, created_on = Date.today )
    cache.add( name, value, created_on )
  end

  def self.cache
    unless @@cache
      @@cache = MeterCat::Cache.new
      at_exit { @@cache.flush_all }
    end
    return @@cache
  end

  def self.config
    return @@config ||= MeterCat::Config.new
  end

  def self.configure
    yield config
  end

end
