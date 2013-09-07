class MeterCat::MeterMailer <  ActionMailer::Base

  add_template_helper( MeterCat::MeterHelper )

  def report
    config = MeterCat.config
    @range = ( Date.yesterday - config.mail_days ) .. Date.yesterday
    @meters = Meter.to_h( @range, config.mail_names )

    mail( :to => config.to, :from => config.from, :subject => config.subject )
  end

end