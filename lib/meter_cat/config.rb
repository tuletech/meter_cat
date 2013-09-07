require 'singleton'

module MeterCat

  class Config
    include Singleton

    attr_accessor :calculator, :expiration, :retry_attempts, :retry_delay
    attr_accessor :from, :mail_days, :mail_names, :subject, :to

    def initialize
      @calculator = MeterCat::Calculator.new
      @expiration = Meter::DEFAULT_EXPIRATION
      @retry_attempts = Meter::DEFAULT_RETRY_ATTEMPTS
      @retry_delay = Meter::DEFAULT_RETRY_DELAY
    end

    def ratio( name, numerator, denominator )
      @calculator.ratio( name, numerator, denominator )
    end

    def percentage( name, numerator, denominator )
      @calculator.percentage( name, numerator, denominator )
    end

    def sum( name, values )
      @calculator.sum( name, values )
    end

  end

end