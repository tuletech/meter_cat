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

    it 'has an #calculator accessor' do
      config.calculator.should_not be_nil
    end

    it 'has an #expiration accessor' do
      config.expiration = Meter::DEFAULT_EXPIRATION
      config.expiration.should eql( Meter::DEFAULT_EXPIRATION )
    end

    it 'has a #from accessor' do
      config.from.should_not be_nil
      config.from = config.from
      config.from.should eql( config.from )
    end

    it 'has an #layout accessor' do
      config.layout.should_not be_nil
    end

    it 'has a #mail_days accessor' do
      config.mail_days.should_not be_nil
      config.mail_days = config.mail_days
      config.mail_days.should eql( config.mail_days )
    end

    it 'has a #retry_attempts accessor' do
      config.retry_attempts = Meter::DEFAULT_RETRY_ATTEMPTS
      config.retry_attempts.should eql( Meter::DEFAULT_RETRY_ATTEMPTS )
    end

    it 'has a #retry_delay accessor' do
      config.retry_delay = Meter::DEFAULT_RETRY_DELAY
      config.retry_delay.should eql( Meter::DEFAULT_RETRY_DELAY )
    end

    it 'has an #subject accessor' do
      config.subject.should_not be_nil
      config.subject = config.subject
      config.subject.should eql( config.subject )
    end

    it 'has a #to accessor' do
      config.to.should_not be_nil
      config.to = config.to
      config.to.should eql( config.to )
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
