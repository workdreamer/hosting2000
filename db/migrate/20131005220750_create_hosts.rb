class CreateHosts < ActiveRecord::Migration
  def self.up
    create_table :hosts do |t|
      t.string :ref, :null => false
      t.string :name
      t.string :address
      t.timestamps
    end
    add_index(:hosts, :ref, :unique => true)
  end

  def self.down
    drop_table :hosts
  end
end
