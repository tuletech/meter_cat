module MeterCat

  class Calculator < Hash

    def ratio( name, numerator, denominator )
      store( name, Divide.new( numerator, denominator, Divide::FORMAT_RATIO ) )
    end

    def percentage( name, numerator, denominator )
      store( name, Divide.new( numerator, denominator, Divide::FORMAT_PERCENTAGE ) )
    end

    def sum( name, values )
      store( name, Sum.new( values ) )
    end

    def calculate( meters, range, names = nil )
      (names || keys).each do |name|
        name = name.to_sym
        if calculation = fetch( name, nil )
          meters[ name ] = {}
          range.each do |date|
            meters[ name ][ date] = fetch( name ).calculate( meters, date )
          end
        end
      end
    end

  end

  #############################################################################
  # Divide

  class Divide
    attr_accessor :numerator, :denominator, :format

    FORMAT_RATIO = "%0.1f"
    FORMAT_PERCENTAGE = "%0.1f\%"

    def initialize( numerator, denominator, format )
      @numerator = numerator
      @denominator = denominator
      @format = format
    end

    def calculate( meters, date )
      numerator = meters[ @numerator ] ? ( meters[ @numerator ][ date ] || 0 ) : 0
      denominator = meters[ @denominator ] ? ( meters[ @denominator ][ date ] || 0 ) : 0

      value = ( 0 == denominator ) ? 0.0 : ( numerator.to_f / denominator.to_f )
      value *= 100 if @format == FORMAT_PERCENTAGE

      return sprintf( @format, value )
    end
  end

  #############################################################################
  # Sum

  class Sum
    attr_accessor :values

    def initialize( values )
      @values = values
    end

    def calculate( meters, date )
      sum = 0
      values.each { |name| sum += ( meters[ name ][ date ] || 0 ) if meters[ name ] }
      return sum
    end
  end

end
