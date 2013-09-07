require 'spec_helper'

include MeterCat

describe MeterCat::MeterController do

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

    it 'converts meters to CSV' do
      Meter.should_receive( :to_csv )
      get :index, :format => 'csv'
    end

    it 'returns CSV' do
      get :index, :format => 'csv'
      response.body.should eql_file( 'spec/data/index.csv' )
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
        Meter.delete_all
        @user_created_3 = FactoryGirl.create( :user_created_3 )
        @login_failed_3 = FactoryGirl.create( :login_failed_3 )

        @date = @user_created_3.created_on
        @days = 30
        @names = [ @user_created_3.name ]

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
        expect( assigns( :meters ) ).to eql( Meter.to_h( range, @names ) )
      end

    end

  end

end