class TimesetController < ApplicationController
  def view
    key = params[:key]
    if key
      @timeset = Timeset.find_by_short_url(key)
      if @timeset.nil?
        redirect_to root_url, :alert => "Your permalink did not resolve. The item may have been deleted, or the link was incorrect."
      end
    else
      @timeset = Timeset.create
    end
    
    @time_ranges = Timeset.time_intervals(6, 9)
  end
end
