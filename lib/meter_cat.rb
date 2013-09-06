require 'meter_cat/engine'
require 'meter_cat/cache'
require 'meter_cat/config'

module MeterCat

  def add( name, value = 1, created_on = Date.today )
    MeterCat::Cache.instance.add( name, value, created_on )
  end

  def self.config
    return MeterCat::Config.instance
  end

  def self.configure
    yield config
  end

end
