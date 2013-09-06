module MeterCat
  module MeterHelper

     # Constructs a single meter description

    def meter_description( name )
      content_tag( :p ) do
        concat content_tag( :b, name )
        concat ' - '
        concat t( name, :scope => :meter_cat )
      end
    end

    # Constructs a list of meter descriptions

    def meter_descriptions( meters )
      content_tag( :ul ) do
        meters.keys.sort.each do |name|
          concat content_tag( :li, meter_description( name ) )
        end
      end
    end

    # Constructs an HTML table header

    def meter_header( range )
      content_tag( :tr ) do
        concat content_tag( :th )
        range.each { |date| concat content_tag( :th, date ) }
      end
    end

    # Constructs an HTML table row

    def meter_row( meters, range, name )
      content_tag( :tr ) do
        concat content_tag( :th, name, :align => 'left' )
        range.each do |date|
          concat content_tag( :td, meters[ name ][ date ] || 0, :align => 'right' )
        end
      end
    end

    # Returns an HTML table

    def meter_table( meters, range )
      content_tag( :table, :border => 1 ) do
        concat meter_header( range )
        meters.keys.sort.each do |name|
          concat meter_row( meters, range, name )
        end
      end
    end

  end
end
