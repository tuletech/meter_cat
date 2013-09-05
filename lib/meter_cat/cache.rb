
module MeterCat
  class Cache < Hash

    # Adds the given value to the hash
    # Flushes expired data to DB

    def add( name, value, created_on )
      meter = fetch( name, nil )

      # If the name isn't cached, cache it and return
      return cache( name, value, created_on ) unless meter

       # If the cached value is for a different day, flush it, cache the new value and return
      if meter.created_on != created_on
        flush( name )
        cache( name, value, created_on )
        return
      end

      # Add the new value to the cached value and flush if expired
      meter.value += value
      flush( name ) if meter.expired?
    end

    # Creates a new Meter and stores is in the hash

    def cache( name, value, created_on )
      meter = Meter.new( :name => name, :value => value, :created_on => created_on, :created_at => Time.now )
      store( name, meter )
    end

    # Flushes data to the DB and removes it from the hash

    def flush( name )
      return unless meter = delete( name )
      meter.add
    end

    # Flushes all keys

    def flush_all
      keys.each { |key| flush( key ) }
    end

  end
end