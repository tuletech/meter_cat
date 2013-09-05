require 'spec_helper'

describe MeterCat::Cache do

  before( :each ) do
    @cache = MeterCat::Cache.new

    @name = :test
    @value = 727
    @date = Date.parse( '2013-09-05' )

    @missing_name = :missing
    @other_date = Date.parse( '1999-09-11' )
  end

  it 'is a subclass of Hash' do
    @cache.should be_a_kind_of( Hash )
  end

  #############################################################################
  # #add
  #############################################################################

  describe '#add' do

    context 'cache miss' do

      it 'stores the new meter' do
        @cache.should_receive( :cache ).with( @name, @value, @date )
        @cache.add( @name, @value, @date )
      end

    end

    context 'cache hit' do

      context 'for different day' do

        before( :each ) do
          @cache.add( @name, @value, @other_date )
        end

        it 'flushes the cache' do
          @cache.should_receive( :flush ).with( @name )
          @cache.add( @name, @value, @date )
        end

        it 'caches the new data' do
          @cache.should_receive( :cache ).with( @name, @value, @date )
          @cache.add( @name, @value, @date )
        end

      end

      context 'for same day' do

        before( :each ) do
          @cache.add( @name, @value, @date )
        end

        context 'not expired' do

          before( :each ) do
            @cache[ @name ].should_receive( :expired? ).once.and_return( false )
          end

          it 'increments the cached value' do
            @cache.add( @name, @value, @date )

            meter = @cache[ @name ]
            meter.should be_present
            meter.name.should eql( @name )
            meter.value.should eql( @value * 2 )
            meter.created_on.should eql( @date )
          end

          it 'does not flush the cache' do
            @cache.should_not_receive( :flush )
            @cache.add( @name, @value, @date )
          end

        end

        it 'flushes the cache if expired' do
          @cache[ @name ].should_receive( :expired? ).once.and_return( true )
          @cache.should_receive( :flush ).with( @name )
          @cache.add( @name, @value, @date )
        end

      end

    end

  end

  #############################################################################
  # #cache
  #############################################################################

  describe '#cache' do

    it 'stores a new meter in the cache' do
      @cache[ @name ].should be_nil
      @cache.cache( @name, @value, @date )

      meter = @cache[ @name ]
      meter.should be_present
      meter.name.should eql( @name )
      meter.value.should eql( @value )
      meter.created_on.should eql( @date )

    end

  end

  #############################################################################
  # #flush
  #############################################################################

  describe '#flush' do

    before( :each ) do
      @cache.add( @name, @value, @date )
    end

    it 'adds the cached meter to the database' do
      @cache[ @name ].should_receive( :add )
      @cache.flush( @name )
    end

    it 'clears the cached meter' do
      @cache[ @name ].should be_present
      @cache.flush( @name )
      @cache[ @name ].should be_nil
    end

    it 'tolerates a cache miss' do
      @cache[ @missing_name ].should be_nil
      @cache.flush( @missing_name )
    end

  end

end