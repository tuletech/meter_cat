require 'meter_cat/engine'
require 'meter_cat/cache'
require 'meter_cat/config'

module MeterCat

  def add( name, value = 1, created_on = Date.today )
    cache.add( name, value, created_on )
  end

  def self.cache
    return @@cache ||= MeterCat::Cache.new
  end

  def self.config
    return @@config ||= MeterCat::Config.new
  end

  def self.configure
    yield config
  end

end
