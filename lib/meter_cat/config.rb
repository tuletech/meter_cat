require 'singleton'

module MeterCat

  class Config
    include Singleton

    attr_accessor :expiration, :retry_attempts, :retry_delay

    def initialize
      @expiration = Meter::DEFAULT_EXPIRATION
      @retry_attempts = Meter::DEFAULT_RETRY_ATTEMPTS
      @retry_delay = Meter::DEFAULT_RETRY_DELAY
    end

    def ratio( name, numerator, denominator )

    end

    def percentage( name, numerator, denominator )


    end

    def sum( name, names )

    end

  end

end