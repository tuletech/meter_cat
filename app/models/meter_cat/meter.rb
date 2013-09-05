module MeterCat
  class Meter < ActiveRecord::Base

    MAX_ADD_ATTEMPTS = 5

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
      attempts = 0
      success = false

      while( attempts < MAX_ADD_ATTEMPTS && !success )
        attempts += 1

        begin
          success = add
        rescue ActiveRecord::StaleObjectError, ActiveRecord::RecordNotUnique
        end
      end

      return success
    end

  end
end
