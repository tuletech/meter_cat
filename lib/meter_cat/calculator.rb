module MeterCat

  class Calculator < Hash

    def ratio(name, numerator, denominator)
      store(name, Divide.new(numerator, denominator, Divide::FORMAT_RATIO))
    end

    def percentage(name, numerator, denominator)
      store(name, Divide.new(numerator, denominator, Divide::FORMAT_PERCENTAGE))
    end

    def sum(name, values)
      store(name, Sum.new(values))
    end

    def calculate(meters, range, names = nil)
      (names || keys).each do |name|
        calculation = fetch(name, nil)
        next unless calculation

        meters[name] = {}
        range.each do |date|
          meters[name][date] = fetch(name).calculate(meters, date)
        end
      end
    end

    # Add any missing names required for calculations that are named

    def dependencies(names)
      names.each do |name|
        calculation = fetch(name, nil)
        next unless calculation

        calculation.dependencies.each do |dependency|
          names << dependency unless names.include?(dependency)
        end
      end
    end
  end

  #############################################################################
  # Divide

  class Divide
    attr_accessor :numerator, :denominator, :format

    FORMAT_RATIO = '%0.1f'.freeze
    FORMAT_PERCENTAGE = "%0.1f\%".freeze

    def initialize(numerator, denominator, format)
      @numerator = numerator
      @denominator = denominator
      @format = format
    end

    # TODO: Rename format attr
    # rubocop:disable Style/FormatString
    def calculate(meters, date)
      numerator = meters[@numerator] ? (meters[@numerator][date] || 0) : 0
      denominator = meters[@denominator] ? (meters[@denominator][date] || 0) : 0

      value = denominator.zero? ? 0.0 : (numerator.to_f / denominator.to_f)
      value *= 100 if @format == FORMAT_PERCENTAGE

      return sprintf(@format, value)
    end

    def dependencies
      [@numerator, @denominator]
    end
  end

  #############################################################################
  # Sum

  class Sum
    attr_accessor :values

    def initialize(values)
      @values = values
    end

    def calculate(meters, date)
      sum = 0
      values.each { |name| sum += (meters[name][date] || 0) if meters[name] }
      return sum
    end

    def dependencies
      values
    end
  end
end
