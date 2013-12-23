require 'spec_helper'

include MeterCat

describe MeterCat do

  before( :each ) do
    @name = :test
    @value = 1
    @date = Date.parse( '2013-09-05' )
    @cache = MeterCat::Cache.instance
  end

  it 'requires the engine' do
    MeterCat::Engine.should_not be_nil
  end

  it 'defines the MeterCat module' do
    MeterCat.should_not be_nil
  end

  #############################################################################
  # MeterCat::add

  describe '::add' do

    it 'adds the data to the cache' do
      @cache.should_receive( :add ).with( @name, @value, @date )
      MeterCat.add( @name, @value, @date )
    end

    it 'defaults date to today' do
      Date.should_receive( :today ).and_return( @date )
      @cache.should_receive( :add ).with( @name, @value, @date )
      MeterCat.add( @name, @value )
    end

    it 'defaults value to 1' do
      Date.should_receive( :today ).and_return( @date )
      @cache.should_receive( :add ).with( @name, @value, @date )
      MeterCat.add( @name )
    end

  end

  #############################################################################
  # MeterCat::config

  describe '::config' do

    it 'returns the configuration' do
      MeterCat.config.should be_an_instance_of( MeterCat::Config )
    end

  end

  #############################################################################
  # MeterCat::configure

  describe '::configure' do

    it 'yields the configuration' do
      MeterCat.configure { |config| config.should be_an_instance_of( MeterCat::Config ) }
    end

  end

  #############################################################################
  # MeterCat::mail

  describe '::mail' do

    it 'mails the report' do
      report = MeterCat::MeterMailer.report
      MeterCat::MeterMailer.should_receive( :report ).and_return( report )
      report.should_receive( :deliver )
      MeterCat.mail
    end

    it 'adds to the :meter_cat_mail meter' do
      MeterCat.should_receive( :add ).with( :meter_cat_mail )
      MeterCat.mail
    end

  end

  #############################################################################
  # MeterCat::names

  describe '::names' do

    it 'returns a concatenation of db names and configured calculations' do
      expected = ( Meter.names + MeterCat::config.calculator.keys ).sort
      MeterCat.names.should eql( expected )
    end
  end

  #############################################################################
  # MeterCat::set

  describe '::set' do

    it 'adds the data to the cache' do
      MeterCat::Meter.should_receive( :set ).with( @name, @value, @date )
      MeterCat.set( @name, @value, @date )
    end

    it 'defaults date to today' do
      Date.should_receive( :today ).and_return( @date )
      MeterCat::Meter.should_receive( :set ).with( @name, @value, @date )
      MeterCat.set( @name, @value )
    end

    it 'defaults value to 1' do
      Date.should_receive( :today ).and_return( @date )
      MeterCat::Meter.should_receive( :set ).with( @name, @value, @date )
      MeterCat.set( @name )
    end

  end

end