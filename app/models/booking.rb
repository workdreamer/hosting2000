class Booking < ActiveRecord::Base
  belongs_to :room, :foreign_key => "room_ref", :primary_key => "ref"
  has_many :hosts, through: :room

end
