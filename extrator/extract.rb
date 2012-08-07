require 'rubygems'
require 'hpricot'

doc = open("programacao.html") { |f| Hpricot(f) }

sessoes = []

(doc/"table.programacao//tr").each do |row|
  hora_inicio = ''
  (row/"/th.horario").each do |cell|
    hora_inicio = cell.inner_text
  end
  (row/"/td/table.sessao").each do |tbl_sessao|
    if (!(tbl_sessao/"/tr/td.titulo").inner_text.empty?)
      sessoes << Hash[
        'hora_inicio' => hora_inicio,
        'duracao' => ((tbl_sessao.parent[:rowspan].to_i * 0.5).to_s + 'h'),
        'titulo' => (tbl_sessao/"/tr/td.titulo").inner_text
      ]
    end
  end

end

puts sessoes
puts sessoes.length