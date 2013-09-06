namespace :meter_cat do

  desc 'Generate a random meter sequence given arguments: [name, min_value, max_value, start_date, stop_date]'
  task :random, [ :name, :min, :max, :start, :stop ] => :environment do |t,args|
    MeterCat::Meter.random( args )
  end

end
