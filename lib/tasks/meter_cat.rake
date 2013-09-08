namespace :meter_cat do

  desc 'Email meter report, as configured'
  task :mail => :environment do
    MeterCat.mail
  end

  desc 'Generate a random meter sequence given arguments: [name, min_value, max_value, days]'
  task :random, [ :name, :min, :max, :days ] => :environment do |t,args|
    MeterCat::Meter.random( args )
  end

end
