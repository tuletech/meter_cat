namespace :meter_cat do

  desc 'Email meter report, as configured'
  task mail: :environment do
    MeterCat.mail
  end

  desc 'Generate a random meter sequence given arguments: [name, min, max, days]'
  task :random, [:name, :min, :max, :days] => :environment do |_t, args|
    MeterCat::Meter.random(args)
  end

end
