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

      @all_names = MeterCat.names
      @range = (@date - @days) .. @date
      @meters = Meter.to_h( @range, @names )

      respond_to do |format|
        format.html
        format.csv { render :text => Meter.to_csv( @range, @names ), :content_type => 'text/csv' }
      end
    end

  end

end