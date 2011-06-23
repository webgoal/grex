module ScheduleHelper
  
  def is_talk_selected?(talk_id, selected_list)
    " active " if selected_list.include? talk_id
  end

  def show_talk_level(level) 
      ("\<span class='"+ActiveSupport::Multibyte::Chars.new(level.downcase).normalize(:kd).gsub(/[^\x00-\x7F]/,'') +"' \>"+ level +"\</span\>").html_safe unless level.nil?
  end
end
