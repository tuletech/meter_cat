require 'spec_helper'

describe MeterCat::Calculator do

  before( :each ) do
    @calculator = MeterCat::Calculator.new
    @numerator = :login_failed
    @denominator = :user_created
  end

  it 'adds a ratio' do
    name = :failed_to_create_ratio
    @calculator.ratio( name, @numerator, @denominator )
    @calculator[ name ].should be_an_instance_of( MeterCat::Divide )
    @calculator[ name ].numerator.should eql( @numerator )
    @calculator[ name ].denominator.should eql( @denominator )
  end

  it 'adds a percentage' do
    name = :failed_to_create_percentage

    @calculator.percentage( name, @numerator, @denominator )
    @calculator[ name ].should be_an_instance_of( MeterCat::Divide )
    @calculator[ name ].numerator.should eql( @numerator )
    @calculator[ name ].denominator.should eql( @denominator )
  end

  it 'adds a sum' do
    name = :failed_plus_create
    values = [ @numerator, @denominator ]

    @calculator.sum( name, values )
    @calculator[ name ].should be_an_instance_of( MeterCat::Sum )
    @calculator[ name ].values.should eql( values )
  end

end