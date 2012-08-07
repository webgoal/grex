require 'rubygems'
require 'hpricot'

doc = open("programacao.html") { |f| Hpricot(f) }

sessoes = []

dia = 5
(doc/"table.programacao").each do |tbl_prog|
  (tbl_prog/"/tr"). each do |row|
    sala = 1
    hora_inicio = ''
    (row/"/th.horario").each do |cell|
      hora_inicio = cell.inner_text
    end
    (row/"/td/table.sessao").each do |tbl_sessao|
      if (!(tbl_sessao/"/tr/td.titulo").inner_text.empty?)
        duracao = tbl_sessao.parent[:rowspan].to_i / 2
        hora_inicio_splited = hora_inicio.split(':')
        if (duracao != 0)
          hora_fim = (hora_inicio_splited[0].to_i + duracao).to_s + ':' + hora_inicio_splited[1]
        else
          if (hora_inicio_splited[1] == '30')
            hora_fim = (hora_inicio_splited[0].to_i + 1).to_s + ':00'
          else
            hora_fim = hora_inicio_splited[0] + ':30'
          end
        end
        sessoes << Hash[
          'dia' => '2012-09-0' + dia.to_s,
          'sala' => sala,
          'hora_inicio' => hora_inicio + ":00",
          'hora_fim' => hora_fim + ":00",
          'titulo' => (tbl_sessao/"/tr/td.titulo").inner_text,
        ]
        sala += 1
      end
    end
  end
  dia += 1
end

puts sessoes
puts sessoes.length
