class MeterCat::MeterMailer <  ActionMailer::Base
  helper MeterCat::MetersHelper

  def report
    config = MeterCat.config
    @range = ( Date.yesterday - config.mail_days ) .. Date.yesterday
    @meters = MeterCat::Meter.to_h( @range, config.mail_names )

    mail( :to => config.to, :from => config.from, :subject => config.subject )
  end

end