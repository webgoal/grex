require 'rubygems'
require 'hpricot'

doc = open("programacao.html") { |f| Hpricot(f) }

sessoes = []
autors = []

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
        
        if(!(tbl_sessao/"tr/th.convidado").inner_text.empty?)
          trilha = 'convidado'
        else  
          trilha = !((tbl_sessao/"tr/th.trilha").inner_text).empty? ? (tbl_sessao/"tr/th.trilha").inner_text : ""
        end
        
        if((tbl_sessao/"/tr/td.titulo").inner_text == "Lightning Talks")
           trilha = 'desenvolvimento;lise;gest;inova;relatos';
        end
           
        tipo = !((tbl_sessao/"tr/th.tipo").inner_text).empty? ? (tbl_sessao/"tr/th.tipo").inner_text : ""  
        nivel = !((tbl_sessao/"tr/th.nivel").inner_text).empty? ? (tbl_sessao/"tr/th.nivel").inner_text : ""
        
        sessoes << Hash[
          'data_inicio' => ('2012-09-0' + dia.to_s) + ' ' + hora_inicio + ":00",
          'data_fim' => ('2012-09-0' + dia.to_s) + ' ' + hora_fim + ":00",
          'sala' => sala,
          'trilha' => trilha,
          'tipo' => tipo,
          'nivel' => nivel,
          'autores' => (tbl_sessao/"tr/td.autores").inner_text.gsub(/( e )|(, )|( \+ )/,"$").split("$"),
          'titulo' => (tbl_sessao/"/tr/td.titulo").inner_text,
        ]
        
        autor_pre = (tbl_sessao/"tr/td.autores").inner_text.gsub(/( e )|(, )|( \+ )/,"$").split("$")
        
        if(!autor_pre.empty?)
          autors = autors | autor_pre
        end
        sala += 1
      end
    end
  end
  dia += 1
end

autors.each do |autor|
  puts 'insert into evento_development.speakers (name,created_at,updated_at) values ("'+autor+'","2012-08-08 09:00:00","2012-08-08 09:00:00");'
end

sessoes.each do |sessao|
  puts 'insert into evento_development.talks (title,start,end,type,level,room,track,created_at,updated_at) values ("'+sessao["titulo"]+'","'+sessao["data_inicio"]+'","'+sessao["data_fim"]+'","'+sessao["tipo"]+'","'+sessao["nivel"]+'","'+sessao["sala"].to_s+'","'+sessao["trilha"]+'","2012-08-08 09:00:00","2012-08-08 09:00:00");'
end  

sessoes.each do |sessao|
  sessao["autores"].each do |autor|
      if(sessao["titulo"] != "Lightning Talks")
        puts 'INSERT INTO evento_development.talks_speakers (talk_id,speaker_id) VALUES ((SELECT id from evento_development.talks where title like "'+sessao["titulo"]+'"),(SELECT id from evento_development.speakers where name like "'+ autor +'"));'
      end  
  end 
end  

#puts autors.sort
#puts autors.length
#puts sessoes
#puts sessoes.length
