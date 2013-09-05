require 'meter_cat/engine'
require 'meter_cat/cache'
require 'meter_cat/config'

module MeterCat

  def self.config
    return MeterCat::Config.instance
  end

  def self.configure
    yield config
  end

end
