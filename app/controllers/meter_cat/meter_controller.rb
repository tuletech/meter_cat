module MeterCat

  class MeterController < ApplicationController

    DEFAULT_DAYS = 7

    def index
      if date = params[ :date ]
        @date = Date.civil( date[ :year ].to_i, date[ :month ].to_i, date[ :day ].to_i )
      end
      @days = params[ :days ].to_i if params[ :days ]
      @names = params[ :names ]

      @date ||= Meter.maximum( :created_on )
      @days ||= DEFAULT_DAYS

      @range = (@date - @days) .. @date
      @meters = Meter.to_h( @range, @names )
    end

  end

end