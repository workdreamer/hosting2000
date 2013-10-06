class HostsController < ApplicationController
  include HostsHelper
  def search

    @hosts = Host.all_bookings.booking_date_free_on(params[:start_date],params[:end_date], params[:type])
              .paginate(:page => params[:page]) if searchParamsDefined?(params)


    @hosts = [].paginate(:page => params[:page]) if !searchParamsDefined?(params)

  end

end
