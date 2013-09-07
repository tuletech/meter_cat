require 'singleton'

module MeterCat

  class Config
    include Singleton

    attr_accessor :calculations, :expiration, :retry_attempts, :retry_delay

    def initialize
      @calculations = {}
      @expiration = Meter::DEFAULT_EXPIRATION
      @retry_attempts = Meter::DEFAULT_RETRY_ATTEMPTS
      @retry_delay = Meter::DEFAULT_RETRY_DELAY
    end

    def ratio( name, numerator, denominator )
      @calculations[ name ] = { :type => :ratio, :numerator => numerator, :denominator => denominator }
    end

    def percentage( name, numerator, denominator )
      @calculations[ name ] = { :type => :percentage, :numerator => numerator, :denominator => denominator }
    end

    def sum( name, values )
      @calculations[ name ] = { :type => :sum, :values => values }
    end

  end

end