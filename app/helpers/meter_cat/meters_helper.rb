module MeterCat
  module MetersHelper

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

    # Renders the _form partial with locals

    def meter_form( date, days, names, all_names )
      render :partial => 'form', :locals => { :date => date, :days => days, :names => names, :all_names => all_names }
    end

    # Constructs an HTML table header

    def meter_header( range )
      content_tag( :tr ) do
        concat content_tag( :th )
        range.to_a.reverse.each { |date| concat content_tag( :th, date.strftime( '%-m/%-d/%y' ) ) }
      end
    end

    # Constructs an HTML table row

    def meter_row( meters, range, name )
      style = cycle( '', 'background-color: #cccccc;' )

      content_tag( :tr ) do
        concat content_tag( :th, name, :align => 'left', :style => style )
        range.to_a.reverse.each do |date|
          value = meters[ name ][ date ] || 0
          concat content_tag( :td, value, :align => 'right', :style => style  )
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
