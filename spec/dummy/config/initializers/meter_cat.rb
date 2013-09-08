MeterCat.configure do |config|

  config.ratio( :failed_to_create_ratio, :login_failed, :user_created )
  config.percentage( :failed_to_create_percentage, :login_failed, :user_created )
  config.sum( :failed_plus_create, [ :login_failed, :user_created ] )

  config.to = 'rdh727@gmail.com' # 'ops@schrodingersbox.com'
  config.from = 'ops@schrodingersbox.com'
  config.subject = "#{Rails.env.upcase} MeterCat Report"
  config.mail_days = 7

end

