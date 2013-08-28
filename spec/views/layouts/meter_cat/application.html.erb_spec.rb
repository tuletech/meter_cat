require 'spec_helper'

describe 'layouts/meter_cat/application.html.erb' do

  it 'includes a title' do
    render
    rendered.should have_selector( :title, :content => 'MeterCat' )
  end

end