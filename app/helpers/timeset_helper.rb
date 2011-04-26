module TimesetHelper
  def day_headers
    html = ""
    
    ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"].each do |day|
      html += "<th>#{day.capitalize}</th>"
    end
    
    html.html_safe
  end
  
  def time_fields(time)
    out = ""
    
    ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"].each do |day|
      out += "<td data-day='#{day}' data-time='#{time}' class='field'></td>"
    end
    
    out.html_safe
  end
end