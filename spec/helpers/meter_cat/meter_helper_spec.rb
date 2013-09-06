require 'spec_helper'

describe MeterCat::MeterHelper do

  fixtures :meters

  before( :each ) do
    @start = meters( :user_created_2 ).created_on
    @stop = meters( :user_created_3 ).created_on
    @range = (@start..@stop)
    @meters = Meter.to_h( @range )
    @name = meters( :user_created_2 ).name.to_sym
  end

  describe '#meter_description' do

    it 'generates a meter description' do
      helper.meter_description( @name ).should eql_file( 'spec/data/meter_description.html' )
    end

  end

  describe '#meter_descriptions' do

    it 'generates a list of meter descriptions' do
      helper.meter_descriptions( @meters ).should eql_file( 'spec/data/meter_descriptions.html' )
    end

  end

  describe '#meter_header' do

    it 'generates a meter table header' do
      helper.meter_header( @range ).should eql_file( 'spec/data/meter_header.html' )
    end

  end

  describe '#meter_row' do

    it 'generates a meter table row' do
      helper.meter_row( @meters, @range, @name ).should eql_file( 'spec/data/meter_row.html' )
    end

  end

  describe '#meter_table' do

    it 'generates a meter table' do
      helper.meter_table( @meters, @range ).should eql_file( 'spec/data/meter_table.html' )
    end

  end

end