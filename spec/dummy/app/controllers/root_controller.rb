class RootController < ApplicationController

  def index
  end

  def mail
    MeterCat.mail
    render :text => 'Mailed'
  end

end