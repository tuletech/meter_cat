require 'spec_helper'

include MeterCat

describe MeterCat::Calculator do

  before( :each ) do
    @calculator = MeterCat::Calculator.new
    @numerator = :login_failed
    @denominator = :user_created
  end

  def setup_calculator
    setup_meters
    @to_h = Meter.to_h( @range, @names )

    @calculator.clear
    @calculator.ratio( :test_ratio, @user_created_1.name.to_sym, @login_failed_3.name.to_sym )
    @calculator.percentage( :test_percentage, @user_created_1.name.to_sym, @login_failed_3.name.to_sym )
    @calculator.sum( :test_sum, [ @user_created_1.name.to_sym, @login_failed_3.name.to_sym ] )
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

  #############################################################################
  # Calculator#calculate

  describe '#calculate' do

    before( :each ) do
      setup_calculator
    end

    it 'fills in calculated values' do
      @calculator.calculate( @to_h, @range )
      [ :test_ratio, :test_percentage, :test_sum ].each do |name|
        @range.each do |date|
          @to_h[ name ][ date ].should be_present
        end
      end
    end

    it 'iterates the list of names, if given' do
      @calculator.calculate( @to_h, @range, [ :test_ratio ]  )
      @to_h[ :test_ratio ].should be_present
      @to_h[ :test_percentage ].should be_nil
      @to_h[ :test_sum ].should be_nil
    end

    it 'iterates all calculated stats when not given a specific list' do
      @calculator.calculate( @to_h, @range, nil  )
      @to_h[ :test_ratio ].should be_present
      @to_h[ :test_percentage ].should be_present
      @to_h[ :test_sum ].should be_present
    end

  end

  #############################################################################
  # Calculator#dependencies

  describe '#dependencies' do

    before( :each ) do
      setup_calculator
    end

    it 'adds dependencies if they are missing' do
      names = [ :test_ratio ]
      @calculator.dependencies( names )
      names.should eql( [ :test_ratio, @user_created_1.name.to_sym, @login_failed_3.name.to_sym ] )
    end


    it 'does not add dependencies if they are already present' do
      names = [ :test_ratio, @user_created_1.name.to_sym, @login_failed_3.name.to_sym ]
      @calculator.dependencies( names )
      names.should eql( [ :test_ratio, @user_created_1.name.to_sym, @login_failed_3.name.to_sym ] )
    end

  end

  #############################################################################
  # MeterCat::Divide

  describe MeterCat::Divide do

    before( :each ) do
      setup_calculator

      @numerator = @user_created_1.name.to_sym
      @denominator = @login_failed_3.name.to_sym
      @format = Divide::FORMAT_RATIO
      @divide = Divide.new( @numerator, @denominator, @format )
    end

    it 'initializes with numerator, denominator, and format' do
      @divide.numerator.should eql( @numerator )
      @divide.denominator.should eql( @denominator )
      @divide.format.should eql( @format )
    end

    it 'calculates a ratio' do
      @divide.calculate( @to_h, @login_failed_3.created_on ).should eql( '0.0' )
    end

    it 'calculates a percentage' do
      @divide = Divide.new( @numerator, @denominator, Divide::FORMAT_PERCENTAGE )
      @divide.calculate( @to_h, @login_failed_3.created_on ).should eql( '0.0%' )
    end

    it 'returns its dependencies' do
      @divide.dependencies.should eql( [ @numerator, @denominator ] )
    end

  end

  #############################################################################
  # MeterCat::Sum

  describe MeterCat::Sum do

    before( :each ) do
      setup_calculator
      @values = [ @user_created_1.name.to_sym, @login_failed_3.name.to_sym ]
      @sum = Sum.new( @values )
    end

    it 'initializes with an array of names' do
      @sum.values.should eql( @values )
    end

    it 'calculates a sum of the specified values' do
      @sum.calculate( @to_h, @login_failed_3.created_on ).should eql( 16 )
    end

    it 'returns its dependencies' do
      @sum.dependencies.should eql( @values )
    end

  end

end