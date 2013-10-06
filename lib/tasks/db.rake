# coding: utf-8
namespace :db do

  task :dump => :environment do
    import_hosts(File.dirname(__FILE__) + "/../../db/data/hosts-2000.csv")
    import_rooms(File.dirname(__FILE__) + "/../../db/data/rooms-2000.csv")
    import_bookings(File.dirname(__FILE__) + "/../../db/data/bookings-2000.csv")
  end

  # This Method will receive a input file to import the hosts
  # file_path string var to receive the full path of the file
  def import_hosts(file_path)
    puts "Importing hosts to database"
    require 'csv'
    CSV.foreach(file_path, :headers => :true, :encoding => "UTF-8") do |row, i|
      next if i == 0 # ignore header row
      ref = get_value(row[0])
      name = get_value(row[1])
      address = get_value(row[2])

      Host.create(:ref => ref, :name => name, :address => address)
    end
  end

  # This Method will receive a input file to import the rooms
  # file_path string var to receive the full path of the file
  def import_rooms(file_path)
    puts "Importing room to database"
    require 'csv'
    CSV.foreach(file_path, :headers => :true, :encoding => "UTF-8") do |row, i|
      next if i == 0 # ignore header row
      ref = get_value(row[0])
      host_ref = get_value(row[1])
      capacity = get_value(row[2])
      Room.create(:ref => ref, :host_ref => host_ref, :capacity => capacity)
    end
  end

  # This Method will receive a input file to import the hosts
  # file_path string var to receive the full path of the file
  def import_bookings(file_path)
    puts "Importing booking to database"
    require 'csv'
    CSV.foreach(file_path, :headers => :true, :encoding => "UTF-8") do |row, i|
      next if i == 0 # ignore header row
      ref = get_value(row[0])
      room_ref = get_value(row[1])
      start_date = get_value(row[2])
      end_date = get_value(row[3])
      number_of_guests = get_value(row[4])
      Booking.create(:ref => ref, :room_ref => room_ref, :start_date => start_date, :end_date => end_date, :number_of_guests => number_of_guests)
    end
  end

  #this method receives the row value, and return a sanitized value
  def get_value(value)
    value.blank? ? '' : value.strip
  end

end