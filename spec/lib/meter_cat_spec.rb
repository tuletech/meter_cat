require 'spec_helper'

describe MeterCat do

  it 'requires the engine' do
    MeterCat::Engine.should_not be_nil
  end

  it 'defines the MeterCat module' do
    MeterCat.should_not be_nil
  end

  describe '::config' do

    it 'returns the configuration' do
      MeterCat.config.should be( MeterCat::Config.instance )
    end

  end

  describe '::configure' do

    it 'yields the configuration' do
      MeterCat.configure { |config| config.should be( MeterCat::Config.instance ) }
    end

  end

end