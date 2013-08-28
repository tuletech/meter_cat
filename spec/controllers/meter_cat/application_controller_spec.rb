require 'spec_helper'

describe MeterCat::ApplicationController do

  it 'is a subclass of ActionController::Base' do
    @controller.should be_a_kind_of( ActionController::Base )
  end

end