module ApplicationHelper
  def normalize_string(talk)
    ActiveSupport::Multibyte::Chars.new(talk.downcase).normalize(:kd).gsub(/[^\x00-\x7F]/,'').to_s
  end
end
