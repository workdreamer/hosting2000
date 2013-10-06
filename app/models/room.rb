class Room < ActiveRecord::Base
  belongs_to :host, :foreign_key => "host_ref", :primary_key => "ref"
  has_many :bookings, :foreign_key => "room_ref", :primary_key => "ref"

  scope :fields, lambda { |start_date, end_date|
    if !start_date.nil? || !end_date.nil?
      {
          :select => ["rooms.*,
                      (
                      SELECT number_of_guests
                      FROM bookings
                      where start_date >= #{Room.sanitize(start_date)} AND end_date <= #{Room.sanitize(end_date)}
                      AND rooms.ref = bookings.room_ref
                      ) booked
                      "]
      }
    else
      {
          :select => ["rooms.*, 0 as booked"]
      }
    end
  }

  scope :all_bookings, -> {
      joins("LEFT JOIN bookings on bookings.room_ref = rooms.ref ")
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

end
