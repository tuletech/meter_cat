require 'spec_helper'

include MeterCat

describe 'meter_cat/meter/index.html.erb' do

  before( :each ) do
    @range = MeterCat::Meter.minimum( :created_on ) .. MeterCat::Meter.maximum( :created_on )
    @meters = Meter.to_h( @range )

    assign( :range, @range )
    assign( :meters, @meters )
  end

  it 'renders a title' do
    render
    rendered.should have_selector( :h1, :content => t( :title, :scope => :meter_cat ) )
  end

  it 'renders the meter table'  do
    view.should_receive( :meter_table ).with( @meters, @range )
    render
  end

  it 'renders a description title' do
    render
    rendered.should have_selector( :h2, :content => t( :descriptions, :scope => :meter_cat ) )
  end

  it 'renders the meter description'  do
    view.should_receive( :meter_descriptions ).with( @meters )
    render
  end

end