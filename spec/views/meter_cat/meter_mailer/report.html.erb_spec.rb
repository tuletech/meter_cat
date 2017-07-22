include MeterCat

describe 'meter_cat/meter_mailer/report.html.erb' do

  before( :each ) do
    view.extend MeterCat::MetersHelper
    setup_meters
    @meters = Meter.to_h( @range )
  end

  it 'renders without exception' do
    assign( :meters, @meters )
    assign( :range, @range )
    render
  end
end