module HostsHelper
  def searchParamsDefined?(params)
      if( params[:guests].blank? || params[:start_date].blank? || params[:end_date].blank?  )
           return false
      end
      true
    end
end
