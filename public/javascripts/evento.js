jQuery(document).ready(function(){
  bindDayChange();
  bindToggleGoingButton();
  setupVouNaoVou();
  exibirPalestraAtual();
});

function bindDayChange() {
  jQuery(".dia_6").hide();
  jQuery(".dia_7").hide();

  jQuery('.botoes .proximo').live('click', function(e) {
    e.preventDefault();
    paginaDireita();
  });

  jQuery('.botoes .anterior').live('click', function(e) {
    e.preventDefault();
    paginaEsquerda();
  });
}

function bindToggleGoingButton() {
  jQuery(".vao").click(function(event) {
    jQuery(".vou").toggleClass('aberto');
    if (jQuery(".vou").hasClass('aberto'))
      jQuery(".info-palestrante, .tipo, .descricao").hide()
    else
      jQuery(".info-palestrante, .tipo, .descricao").show()
  })
}

function paginaDireita() {
  dia = parseInt(jQuery(".dia").attr("atual")[4]);

  if(dia < 7) {
    dia++;
    jQuery(".dia").attr("atual",("dia_" + dia.toString()));

    jQuery(".grupo").hide();
    jQuery(".dia_" + dia.toString()).show();
  }
  atualizaDia(dia);
}

function paginaEsquerda() {	
  dia = parseInt(jQuery(".dia").attr("atual")[4]);

  if(dia > 5) {
    dia--;
    jQuery(".dia").attr("atual",("dia_" + dia.toString()));

    jQuery(".grupo").hide();
    jQuery(".dia_" + dia.toString()).show();
  }
  atualizaDia(dia);
}

function atualizaDia(dia) {
  dias = {
    5 : "Quarta-feira",
    6 : "Quinta-feira",
    7 : "Sexta-feira"
  }

  jQuery(".numero").html(dia+"/9");
  jQuery(".dia").html(dias[dia]);
}

function setupVouNaoVou() {
  jQuery('a.btn-vou').click(function(event) {
    event.preventDefault();
    link = jQuery(this);
    linha = link.parent().parent();
    //if(linha.hasClass('load')) {
    //	return true;
    //}
    //linha.addClass('load');
    palestraId = linha.find('input[type=hidden]').val();
    qtd = linha.find('a.vao');
    if (linha.hasClass('active')) {
      jQuery.get('/schedules/uncheck', { 'palestra': palestraId }, function(data) {
        jQuery('div.linha, div.title').find('input[value='+palestraId+']').parent().removeClass('active');
        linha.removeClass('load');
        qtd.html(parseInt(qtd.html())-1);
      }, 'json');
    } else {
      jQuery.get('/schedules/check', { 'palestra': palestraId }, function(data) {
        parent = jQuery('div.linha, div.title').find('input[value='+palestraId+']').parent();
        parent.addClass('active');
        linha.removeClass('load');
        qtd.html(parseInt(qtd.html())+1);
      }, 'json');
    }
  });
}

function exibirPalestraAtual() {
  now = Math.round((new Date()).getTime() / 1000) - (new Date().getTimezoneOffset() * 60);
  jQuery('.linha-nova').removeClass('now');
  jQuery('div.horario').each(function(){
    me = jQuery(this);
    start = me.find('.start').val();
    end = me.find('.end').val();
    if ((start-now) <= 0 && (end-now) > 0) {
      me.parent().addClass('now');
    }
  });
}