require 'spec_helper'

describe MeterCat::MeterController do
  fixtures :meters
  routes { MeterCat::Engine.routes }

  it 'is a subclass of ApplicationController' do
    @controller.should be_a_kind_of( ApplicationController )
  end

  it 'defines a constant for default number of days to report on' do
    MeterController::DEFAULT_DAYS.should be_present
  end

  describe '#index' do

    it 'gets successfully' do
      get :index
      response.should be_success
    end

    context 'without params' do

      before( :each ) do
        @date = Meter.maximum( :created_on )
        @days = MeterController::DEFAULT_DAYS

        get :index
      end

      it 'uses default values' do
        expect( assigns( :date ) ).to eql( @date )
        expect( assigns( :days ) ).to eql( @days )
        expect( assigns( :names ) ).to be_nil
      end

      it 'assigns range and meters' do
        range = (@date - @days) .. @date

        expect( assigns( :range ) ).to eql( range )
        expect( assigns( :meters ) ).to eql( Meter.to_h( range ) )
      end

    end

    context 'with params' do

      before( :each ) do
        @date = Date.civil( 1971, 7, 27 )
        @days = 30
        @names = [ meters( :user_created_1 ).name ]

        params = {
            :date => {
                :month => @date.month.to_s,
                :day => @date.day.to_s,
                :year => @date.year.to_s
            },
            :days => @days.to_s,
            :names => @names
        }

        get :index, params
      end

      it 'uses param values' do
        expect( assigns( :date ) ).to eql( @date )
        expect( assigns( :days ) ).to eql( @days )
        expect( assigns( :names ) ).to eql( @names )
      end

      it 'assigns range and meters' do
        range = (@date - @days) .. @date

        expect( assigns( :range ) ).to eql( range )
        expect( assigns( :meters ) ).to eql( Meter.to_h( range ) )
      end

    end

  end

end