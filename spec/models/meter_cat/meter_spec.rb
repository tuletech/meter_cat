require 'spec_helper'

include MeterCat

describe MeterCat::Meter do

  before( :each ) do
    Kernel.stub( :sleep )

    Meter.delete_all
    @meter = Meter.new( :name => 'test', :created_on => '2013-09-04', :value => 727 )
  end

  describe 'constants' do

    it 'defines a default expiration time' do
      Meter::DEFAULT_EXPIRATION.should be( 3600 )
    end

    it 'defines a default number of retry attempts' do
      Meter::DEFAULT_RETRY_ATTEMPTS.should be( 5 )
    end

    it 'defines a default delay between retries' do
      Meter::DEFAULT_RETRY_DELAY.should be( 1 )
    end

  end

  it 'validates the presence of name' do
    @meter.should be_valid

    @meter.name = nil
    @meter.should be_invalid
    @meter.errors[ :name ].should_not be_empty
  end

  #############################################################################
  # #add
  #############################################################################

  describe '#add' do

    it 'creates a new record' do
      @meter.add.should be_true

      test = Meter.find_by_name_and_created_on( @meter.name, @meter.created_on )
      test.should be_present
      test.value.should eql( @meter.value )
    end

    it 'increments an existing record' do
      @meter.save.should be_true
      @meter.add.should be_true

      test = Meter.find_by_name_and_created_on( @meter.name, @meter.created_on )
      test.should be_present
      test.value.should eql( @meter.value * 2 )
    end

    it 'returns the result of the save' do
      Meter.should_receive( :find_by_name_and_created_on ).twice.and_return( @meter )

      [ true, false ].each do |boolean|
        @meter.should_receive( :save ).and_return( boolean )
        @meter.add.should eql( boolean )
      end
    end

    it 'does not catch ActiveRecord::StaleObjectError exceptions' do
      @meter.lock_version = 1
      @meter.save.should be_true

      Meter.should_receive( :find_by_name_and_created_on ).and_return( @meter )
      @meter.lock_version = 0
      expect { @meter.add }.to raise_error( ActiveRecord::StaleObjectError )
    end

    it 'does not catch ActiveRecord::RecordNotUnique exceptions' do
      @meter.save.should be_true
      Meter.should_receive( :find_by_name_and_created_on ).and_return( nil )

      expect { @meter.add }.to raise_error( ActiveRecord::RecordNotUnique )
    end

  end

  #############################################################################
  # #add_with_retry
  #############################################################################

  describe '#add_with_retry' do

    before( :each ) do
      @retry_attempts = MeterCat.config.retry_attempts
    end

    it 'calls #add' do
      @meter.should_receive( :add ).once.and_return( true )
      @meter.add_with_retry.should be_true
    end

    it 'returns true if it succeeds' do
      @meter.add_with_retry.should be_true
    end

    it 'catches ActiveRecord::StaleObjectError exceptions' do
      @meter.should_receive( :add ).exactly( @retry_attempts ).times.and_raise( ActiveRecord::StaleObjectError.new( nil, nil ) )
      @meter.add_with_retry.should be_false
    end

    it 'catches ActiveRecord::RecordNotUnique exceptions' do
      @meter.should_receive( :add ).exactly( @retry_attempts ).times.and_raise( ActiveRecord::RecordNotUnique.new( nil, nil ) )
      @meter.add_with_retry.should be_false
    end

    it 'retries up to Meter::MAX_ADD_ATTEMPTS times' do
      @meter.should_receive( :add ).exactly( @retry_attempts ).times.and_return( false )
      @meter.add_with_retry.should be_false
    end

    it 'sleeps on each retry' do
      Kernel.should_receive( :sleep ).exactly( @retry_attempts ).times
      @meter.should_receive( :add ).exactly( @retry_attempts ).times.and_return( false )
      @meter.add_with_retry.should be_false
    end

    it 'returns false if it fails' do
      @meter.should_receive( :add ).exactly( @retry_attempts ).times.and_return( false )
      @meter.add_with_retry.should be_false
    end

    it 'succeeds if a retry works' do
      @meter.should_receive( :add ).twice.and_return( false, true )
      @meter.add_with_retry.should be_true
    end

  end

end

