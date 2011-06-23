module ApplicationHelper
  def normalize_string(talk)
    ActiveSupport::Multibyte::Chars.new(talk.downcase).normalize(:kd).gsub(/[^\x00-\x7F]/,'').to_s
  end
  
  def print_speakers(speakers)
    speakers.map {|speaker| speaker.name}.join(', ')
  end
end
