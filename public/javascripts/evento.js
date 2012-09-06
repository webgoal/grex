jQuery(document).ready(function(){
  bindDayChange();
  bindToggleAttendeesTab();
  bindGoButton();
  exibirPalestraAtual();
});

function bindDayChange() {
  dia = new Date().toString().substring(9, 10);
  if (dia <=5) {
    jQuery(".dia_6").hide();
    jQuery(".dia_7").hide();
    jQuery(".data .numero").text("5/9");
    jQuery(".data .dia").text("Quarta-feira");
  } else if (dia = 6) {
    jQuery(".dia_5").hide();
    jQuery(".dia_7").hide();
    jQuery(".data .numero").text("6/9");
    jQuery(".data .dia").text("Quinta-feira");
  } else {
    jQuery(".dia_5").hide();
    jQuery(".dia_6").hide();
    jQuery(".data .numero").text("7/9");
    jQuery(".data .dia").text("Sexta-feira");
  }

  classe_dia_atual = ".dia_" + dia;
  jQuery(classe_dia_atual).show();

  jQuery('.botoes .proximo').live('click', function(e) {
    e.preventDefault();
    paginaDireita();
  });

  jQuery('.botoes .anterior').live('click', function(e) {
    e.preventDefault();
    paginaEsquerda();
  });
}

function bindToggleAttendeesTab() {
  jQuery(".vao").click(function(event) {
    jQuery(".vou").toggleClass('aberto');
    if (jQuery(".vou").hasClass('aberto'))
      jQuery(".info-palestrante, .tipo, .descricao").hide()
    else
      jQuery(".info-palestrante, .tipo, .descricao").show()
  })
}

function paginaDireita() {
  var dia = parseInt(jQuery(".dia").attr("atual")[4]);

  if(dia < 7) {
    dia++;
    jQuery(".dia").attr("atual",("dia_" + dia.toString()));

    jQuery(".grupo").hide();
    jQuery(".dia_" + dia.toString()).show();
  }
  atualizaDia(dia);
}

function paginaEsquerda() {	
  var dia = parseInt(jQuery(".dia").attr("atual")[4]);

  if(dia > 5) {
    dia--;
    jQuery(".dia").attr("atual",("dia_" + dia.toString()));

    jQuery(".grupo").hide();
    jQuery(".dia_" + dia.toString()).show();
  }
  atualizaDia(dia);
}

function atualizaDia(dia) {
  var dias = {
    5 : "Quarta-feira",
    6 : "Quinta-feira",
    7 : "Sexta-feira"
  }

  jQuery(".numero").html(dia+"/9");
  jQuery(".dia").html(dias[dia]);
}

function bindGoButton() {
  jQuery('a.btn-vou').click(function(event) {
    event.preventDefault();

    var talk_id = jQuery('#talk_id').val();
    if (!jQuery('.vou').hasClass('active')) {
      jQuery('.vou').addClass('active');
      jQuery('.vao').html(parseInt(jQuery('.vao').text())+1);
      jQuery.get('/schedules/check', {'palestra': talk_id});

      if (jQuery('.lista-avatar .current_user_attending').length == 0)
        jQuery('.lista-avatar').append(jQuery('.current_user_attending'))
      else
        jQuery('.lista-avatar .current_user_attending').show()

    } else {
      jQuery('.vou').removeClass('active');
      jQuery('.vao').html(parseInt(jQuery('.vao').text())-1);
      jQuery.get('/schedules/uncheck', {'palestra': talk_id});

      if (jQuery('.lista-avatar .current_user_attending'))
        jQuery('.lista-avatar .current_user_attending').hide()
    }

  });
}

function exibirPalestraAtual() {
  var now = Math.round((new Date()).getTime() / 1000) - (new Date().getTimezoneOffset() * 60);
  jQuery('.linha-nova').removeClass('now');
  jQuery('div.horario').each(function(){
    var me = jQuery(this);
    start = me.find('.start').val();
    var end = me.find('.end').val();
    if ((start-now) <= 0 && (end-now) > 0) {
      me.parent().addClass('now');
    }
  });
}