module ScheduleHelper
  
  def is_talk_selected?(talk_id, selected_list)
    " active " if selected_list.include? talk_id
  end
  
end
