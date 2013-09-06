module MeterCat

  class MeterController < ApplicationController

    def index
      @start = Date.today - 7
      @stop = Date.today

      @range = @start .. @stop
      @meters = {}

      Meter.select( 'name,created_on,value' ).where( :created_on => @range ).find_each do |meter|
        name = meter.name.to_sym
        @meters[ name ] ||= {}
        @meters[ name ][ meter.created_on ] = meter.value
      end
    end

  end

end