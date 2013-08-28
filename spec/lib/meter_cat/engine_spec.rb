require 'spec_helper'

describe MeterCat::Engine do

  it 'isolates the MeterCat namespace' do
    MeterCat::Engine.isolated.should be_true
  end

end