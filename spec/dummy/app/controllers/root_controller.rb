class RootController < ApplicationController

  def index
  end

  def mail
    MeterCat::MeterMailer.report.deliver
    render :text => 'Mailed'
  end

end