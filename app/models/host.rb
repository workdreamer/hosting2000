class Host < ActiveRecord::Base
  has_many :rooms, :foreign_key => "host_ref", :primary_key => "ref"
  has_many :bookings, through: :rooms

  scope :all_bookings, lambda {
    {
      :select => "hosts.*",
      :joins => [:rooms, "LEFT JOIN bookings on bookings.room_ref = rooms.ref"],
      :group => "hosts.ref",
      :order => :id
    }
  }

  scope :booking_date_free_on, lambda { |start_date, end_date, desired_guests|
        if start_date.nil? || end_date.nil? || desired_guests.nil?
        {
        }
        else
        {
          :conditions => ["rooms.ref NOT IN (SELECT room_ref
                                              FROM bookings
                                              WHERE  start_date >= ? AND end_date <= ?
                                              )
                        OR bookings.start_date >= ? AND bookings.end_date <= ? AND bookings.number_of_guests + ? <= rooms.capacity
                        ", start_date, end_date, start_date, end_date, desired_guests]
        }
        end
    }

  self.per_page = 5

end
