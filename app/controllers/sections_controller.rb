class SectionsController < ApplicationController
  def index
    timeset = Timeset.find_by_short_url params[:key]
    @sections = timeset.sections
    
    respond_to do |format|
      format.js { render :json => @sections }
    end
  end
  
  def create
    t = Timeset.find_by_short_url params[:short_url]
    
    attributes = {
      :day => params[:day],
      :timeset_id => t.id
    }
    
    times = {
      :start => params[:start_time],
      :end => params[:end_time]
    }
    
    times = Timeset.clean_times times
    
    @section = Section.create attributes.merge(times)
    
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @id = params[:id]
    section = Section.find @id
    section.delete
    respond_to do |format|
      format.js
    end
  end
end
