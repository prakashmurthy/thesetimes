class TimesetsController < ApplicationController
  def view
    key = params[:key]
    if key
      @timeset = Timeset.find_by_short_url(key)
      @new_flag = "old"
      if @timeset.nil?
        redirect_to root_url, :alert => "Your permalink did not resolve. The item may have been deleted, or the link was incorrect. We created a new one for you."
      end
    else
      @timeset = Timeset.create
      @new_flag = "new"
    end
    
    @time_ranges = Timeset.time_intervals(6, 9)
  end
end
