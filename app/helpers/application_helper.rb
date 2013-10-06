module ApplicationHelper
  def guest_select(asset)
    select_values = Array.new
    16.times { |index|
      next if index == 0
      row = Array.new
      row = ["#{index} guest", index] if index == 1
      row = ["#{index} guests", index] if index > 1
      select_values << row
    }
    asset = 1 if asset.nil?
    select_tag(:guests, options_for_select(select_values, asset))
  end
end
