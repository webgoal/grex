require 'test_helper'

class TalkTest < ActiveSupport::TestCase
  def test_find_talk_by_day_and_track_multiple
    engenharia = Talk.track_day '2011-06-30', 'engenharia'
    assert engenharia.size == 2
    assert_equal "Priorizando a Felicidade", engenharia[0].title 
    assert_equal "Tente Desenvolver Diferente com TDD", engenharia[1].title 
  end
  
  def test_find_talk_by_day_and_track_single
    relatos = Talk.track_day '2011-06-30', 'relatos'
    assert relatos.size == 1
    assert_equal "Priorizando a Felicidade", relatos[0].title
  end
  
  def test_viewers
    talk = Talk.new
    talk.id = 2
    assert_equal 2, talk.viewers
  end
end
