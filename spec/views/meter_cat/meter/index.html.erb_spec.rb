require 'spec_helper'

describe 'meter_cat/meter/index.html.erb' do

  it 'includes placeholder text' do
    render
    rendered.should have_selector( :i, :content => 'Meters go here' )
  end

end