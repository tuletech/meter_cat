module MeterCat

  class MeterController < ApplicationController

    def index
      @start = Date.today - 7
      @stop = Date.today

      @range = @start .. @stop
      @meters = Meter.to_h( @range )
    end

  end

end