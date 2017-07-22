describe 'meter_cat/meter_mailer/report.text.erb' do

  it 'renders without exception' do
    render
    rendered.should eql( t( :html_only, :scope => :meter_cat ) )
  end
end