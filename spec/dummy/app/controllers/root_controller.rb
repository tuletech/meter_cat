class RootController < ApplicationController

  helper MeterCat::MetersHelper
  helper StatusCat::StatusHelper

  def index
    @range = (Date.today - 7) .. Date.today
    @meters = MeterCat::Meter.to_h( @range )
  end

  def mail
    MeterCat.mail
    render :text => 'Mailed'
  end

end