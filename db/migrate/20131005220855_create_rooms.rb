class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.string :ref, :null => false
      t.string :host_ref
      t.integer :capacity
      t.timestamps
    end
    add_index(:rooms, :ref, :unique => true)
    #add a foreign key
      execute <<-SQL
        ALTER TABLE rooms
          ADD CONSTRAINT host_ref
          FOREIGN KEY (host_ref)
          REFERENCES hosts(ref)
      SQL
  end

  def self.down
    execute <<-SQL
              ALTER TABLE rooms
                DROP FOREIGN KEY host_ref
            SQL
    drop_table :hosts
  end
end
