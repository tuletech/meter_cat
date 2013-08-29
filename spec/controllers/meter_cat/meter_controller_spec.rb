require 'spec_helper'

describe MeterCat::MeterController do

  it 'is a subclass of ApplicationController' do
    @controller.should be_a_kind_of( ApplicationController )
  end

  describe '#index' do

    it 'gets successfully' do
      get :index, :use_route => :meter_cat
      response.should be_success
    end

  end

end