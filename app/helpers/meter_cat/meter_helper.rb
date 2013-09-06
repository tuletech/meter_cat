module MeterCat
  module MeterHelper

    # Constructs an HTML table header

    def meter_header( range )
      content_tag( :tr ) do
        concat content_tag( :th  )
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

    # Returns an HTML title

    def meter_title
      content_tag( :h1, t( :h1, :scope => :meter_cat ) )
    end

  end
end
