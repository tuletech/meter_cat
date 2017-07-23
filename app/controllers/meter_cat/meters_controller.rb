module MeterCat

  class MetersController < ApplicationController

    layout :set_layout

    before_action :_authenticate!
    before_action :_authorize!

    DEFAULT_DAYS = 7

    def index
      set_meters

      respond_to do |format|
        format.html { MeterCat.add(:meter_cat_html) }
        format.csv do
          MeterCat.add(:meter_cat_csv)
          render plain: Meter.to_csv(@range, @names), content_type: 'text/csv'
        end
      end
    end

    private

    def set_layout
      return MeterCat.config.layout
    end

    def _authenticate!
      instance_eval(&MeterCat.config.authenticate_with)
    end

    def _authorize!
      instance_eval(&MeterCat.config.authorize_with)
    end

    # rubocop:disable Metrics/AbcSize
    def set_meters
      date = params[:date]
      @date = Date.civil(date[:year].to_i, date[:month].to_i, date[:day].to_i) if date

      @days = params[:days].to_i if params[:days]
      @names = params[:names].map(&:to_sym) if params[:names]

      @all_names = MeterCat.names
      @date ||= Date.today
      @days ||= DEFAULT_DAYS

      @range = (@date - @days)..@date
      @meters = Meter.to_h(@range, @names)
    end
  end
end
