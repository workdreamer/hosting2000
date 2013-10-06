class CreateBookings < ActiveRecord::Migration
  def self.up
    create_table :bookings do |t|
      t.string :ref, :null => false
      t.string :room_ref
      t.date :start_date
      t.date :end_date
      t.integer :number_of_guests
      t.timestamps
    end
    add_index(:bookings, :ref, :unique => true)
    #add a foreign key
      execute <<-SQL
        ALTER TABLE bookings
          ADD CONSTRAINT room_ref
          FOREIGN KEY (room_ref)
          REFERENCES rooms(ref)
      SQL
  end

  def self.down
    execute <<-SQL
              ALTER TABLE bookings
                DROP FOREIGN KEY room_ref
            SQL
    drop_table :hosts
  end
end
