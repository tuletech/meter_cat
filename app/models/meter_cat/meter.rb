# A Meter is simply an integer value for a unique name+date pair

module MeterCat
  class Meter < ActiveRecord::Base

    # The expiration time for an in-memory cached meter

    DEFAULT_EXPIRATION = 3600

    # The number of retries in the event of an optimistic locking failure or creation collision

    DEFAULT_RETRY_ATTEMPTS = 5

    # The delay between retries, in seconds.
    # Not using exponential back-off to prevent blocking controllers.
    # Better to lose a little data than create a bad user experience.

    DEFAULT_RETRY_DELAY = 1

    validates :name, :presence => true

    # Create an object for this name+date in the db if one does not already exist.
    # Add the value from this object to the one in the DB.
    # Returns the result of the ActiveRecord save operation.

    def add
      meter = Meter.find_by_name_and_created_on( name, created_on )
      meter ||= Meter.new( :name => name, :created_on => created_on )
      meter.value += value
      return meter.save
    end

    # Calls #add with retry logic up to ::MAX_ADD_ATTEMPTS times.
    # Catches ActiveRecord::StaleObjectError and ActiveRecord::RecordNotUnique for retries.
    # Returns the result of the final call to #add

    def add_with_retry
      success = false

      (1..MeterCat.config.retry_attempts).each do
        begin
          break if success = add
        rescue ActiveRecord::StaleObjectError, ActiveRecord::RecordNotUnique
        end
        Kernel.sleep( MeterCat.config.retry_delay )
      end

      return success
    end


    def expired?

      # TODO implement

      return false
    end

  end
end
