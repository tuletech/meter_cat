require 'spec_helper'

include MeterCat

describe MeterCat::Config do

  let( :config ) { MeterCat::Config.instance }

  it 'is a singleton' do
    config.should be( MeterCat::Config.instance )
  end

  describe 'attributes' do

    it 'has an #expiration accessor' do
      config.expiration = Meter::DEFAULT_EXPIRATION
      config.expiration.should eql( Meter::DEFAULT_EXPIRATION )
    end

    it 'has a #retry_attempts accessor' do
      config.retry_attempts = Meter::DEFAULT_RETRY_ATTEMPTS
      config.retry_attempts.should eql( Meter::DEFAULT_RETRY_ATTEMPTS )
    end

    it 'has a #retry_delay accessor' do
      config.retry_delay = Meter::DEFAULT_RETRY_DELAY
      config.retry_delay.should eql( Meter::DEFAULT_RETRY_DELAY )
    end

  end

end
