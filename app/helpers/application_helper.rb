module ApplicationHelper
  def normalize_string(talk)
    ActiveSupport::Multibyte::Chars.new(talk.downcase).normalize(:kd).gsub(/[^\x00-\x7F]/,'').to_s
  end
  
  def print_speakers(speakers)
    speakers.map {|speaker| speaker.name}.join(', ')
  end
  
  def is_talk_selected?(talk_id, selected_list)
    " active " if selected_list.include? talk_id
  end
  
  def show_talk_level(level) 
      ("\<span class='"+ActiveSupport::Multibyte::Chars.new(level.downcase).normalize(:kd).gsub(/[^\x00-\x7F]/,'') +"' \>"+ level +"\</span\>").html_safe unless level.nil?
  end
end
