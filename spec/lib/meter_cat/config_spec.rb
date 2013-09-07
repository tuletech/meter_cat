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
      config.calculator.should be_a_kind_of( Hash )
      config.calculator.should be_empty

      config.expiration.should eql( Meter::DEFAULT_EXPIRATION )
      config.retry_attempts.should eql( Meter::DEFAULT_RETRY_ATTEMPTS )
      config.retry_delay.should eql( Meter::DEFAULT_RETRY_DELAY )
    end

  end

  describe 'calculator' do

    before( :each ) do
      config.calculator = MeterCat::Calculator.new
    end

    it 'adds a ratio' do
      config.calculator.should_receive( :ratio ).with( :failed_to_create_ratio, :login_failed, :user_created )
      config.ratio( :failed_to_create_ratio, :login_failed, :user_created )
    end

    it 'adds a percentage' do
      config.calculator.should_receive( :percentage ).with( :failed_to_create_percentage, :login_failed, :user_created )
      config.percentage( :failed_to_create_percentage, :login_failed, :user_created )
    end

    it 'adds a sum' do
      values = [ :login_failed, :user_created ]
      config.calculator.should_receive( :sum ).with( :failed_plus_create, values )
      config.sum( :failed_plus_create, values )
    end

  end

end
