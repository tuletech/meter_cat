require 'spec_helper'

describe MeterCat::MeterHelper do

  before( :each ) do
    MeterCat::Meter.delete_all
    @user_created_1 = FactoryGirl.create( :user_created_1 )
    @user_created_2 = FactoryGirl.create( :user_created_2 )
    @user_created_3 = FactoryGirl.create( :user_created_3 )
    @login_failed_3 = FactoryGirl.create( :login_failed_3 )

    @start = @user_created_1.created_on
    @stop = @user_created_3.created_on
    @range = (@start..@stop)
    @meters = MeterCat::Meter.to_h( @range )
  end

  describe '#meter_description' do

    it 'generates a meter description' do
      helper.meter_description( 'descriptions' ).should eql_file( 'spec/data/meter_description.html' )
    end

  end

  describe '#meter_descriptions' do

    it 'generates a list of meter descriptions' do
      helper.meter_descriptions( @meters ).should eql_file( 'spec/data/meter_descriptions.html' )
    end

  end

  describe '#meter_form' do

    it 'renders the _form partial with locals' do
      helper.should_receive( :render )
      helper.meter_form( @start, 5, nil, Meter.names )
    end

  end

  describe '#meter_header' do

    it 'generates a meter table header' do
      helper.meter_header( @range ).should eql_file( 'spec/data/meter_header.html' )
    end

  end

  describe '#meter_row' do

    it 'generates a meter table row' do
      helper.meter_row( @meters, @range, @meters.keys.sort.first ).should eql_file( 'spec/data/meter_row.html' )
    end

  end

  describe '#meter_table' do

    it 'generates a meter table' do
      helper.meter_table( @meters, @range ).should eql_file( 'spec/data/meter_table.html' )
    end

  end

end