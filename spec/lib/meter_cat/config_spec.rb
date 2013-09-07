require 'spec_helper'

include MeterCat

describe MeterCat::Config do

  let( :config ) { MeterCat::Config.instance }

  it 'is a singleton' do
    config.should be( MeterCat::Config.instance )
  end

  #############################################################################
  # attributes

  describe 'attributes' do

    it 'has an #expiration accessor' do
      config.expiration = Meter::DEFAULT_EXPIRATION
      config.expiration.should eql( Meter::DEFAULT_EXPIRATION )
    end

    it 'has a #retry_attempts accessor' do
      config.retry_attempts = Meter::DEFAULT_RETRY_ATTEMPTS
      config.retry_attempts.should eql( Meter::DEFAULT_RETRY_ATTEMPTS )
    end

    it 'has a #retry_delay accessor' do
      config.retry_delay = Meter::DEFAULT_RETRY_DELAY
      config.retry_delay.should eql( Meter::DEFAULT_RETRY_DELAY )
    end

  end

  #############################################################################
  # Config#initialize

  describe '#initialize' do

    it 'sets default values' do
      config.send( :initialize )
      config.calculations.should be_an_instance_of( Hash )
      config.calculations.should be_empty

      config.expiration.should eql( Meter::DEFAULT_EXPIRATION )
      config.retry_attempts.should eql( Meter::DEFAULT_RETRY_ATTEMPTS )
      config.retry_delay.should eql( Meter::DEFAULT_RETRY_DELAY )
    end

  end

  describe 'calculations' do

    before( :each ) do
      config.calculations = {}
    end

    it 'adds a ratio' do
      expected = { :type => :ratio, :numerator => :login_failed, :denominator => :user_created }
      config.ratio( :failed_to_create_ratio, :login_failed, :user_created )
      config.calculations[ :failed_to_create_ratio ].should eql( expected )
    end

    it 'adds a percentage' do
      expected = { :type => :percentage, :numerator => :login_failed, :denominator => :user_created }
      config.percentage( :failed_to_create_percentage, :login_failed, :user_created )
      config.calculations[ :failed_to_create_percentage ].should eql( expected )
    end

    it 'adds a sum' do
      expected = { :type => :sum, :values => [ :login_failed, :user_created ] }
      config.sum( :failed_plus_create, expected[ :values ] )
      config.calculations[ :failed_plus_create ].should eql( expected )
    end

  end

end
