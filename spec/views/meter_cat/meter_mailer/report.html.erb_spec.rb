require 'spec_helper'

include MeterCat

describe 'meter_cat/meter_mailer/report.html.erb' do

  before( :each ) do
    view.extend MeterCat::MeterHelper
    setup_meters
    @meters = Meter.to_h( @range )
  end

  it 'renders without exception' do
    assign( :meters, @meters )
    assign( :range, @range )
    render
  end

end