require 'spec_helper'

describe MeterCat do

  it 'requires the engine' do
    MeterCat::Engine.should_not be_nil
  end

  it 'defines the MeterCat module' do
    MeterCat.should_not be_nil
  end

  describe '::add' do

    before( :each ) do
      @name = :test
      @value = 1
      @date = Date.parse( '2013-09-05' )
    end

    it 'adds the data to the cache' do
      MeterCat.cache.should_receive( :add ).with( @name, @value, @date )
      MeterCat.add( @name, @value, @date )
    end

    it 'defaults date to today' do
      Date.should_receive( :today ).and_return( @date )
      MeterCat.cache.should_receive( :add ).with( @name, @value, @date )
      MeterCat.add( @name, @value )
    end

    it 'defaults value to 1' do
      MeterCat.cache.should_receive( :add ).with( @name, @value, @date )
      MeterCat.add( @name )
    end

  end

  describe '::cache' do

    it 'returns the cache' do
      MeterCat.cache.should be_an_instance_of( MeterCat::Cache )
    end

  end

  describe '::config' do

    it 'returns the configuration' do
      MeterCat.config.should be_an_instance_of( MeterCat::Config )
    end

  end

  describe '::configure' do

    it 'yields the configuration' do
      MeterCat.configure { |config| config.should be_an_instance_of( MeterCat::Config ) }
    end

  end

end