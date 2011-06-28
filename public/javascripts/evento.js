jQuery(document).ready(function(){
	var inicio = 0;
	var trilhaVisivel = null;
	document.addEventListener('touchstart', function(event) {
		trilhaVisivel = jQuery('.trilha:visible .slider');
		inicio = event.touches[0].pageX;
	}, false);
	document.addEventListener('touchmove', function(event) {
		variacao = event.touches[0].pageX - inicio;
		trilhaVisivel.offset({ top: this.top, left: variacao });
	}, false);
	document.addEventListener('touchend', function(event) {
		trilhaVisivel.offset({ top: this.top, left: 0 })
		inicio = 0;
	}, false);

	bindSwipe();
	setupVouNaoVou();
	exibirPalestraAtual();
	
});

function bindSwipe() {
	jQuery('.trilha').live('swipeleft', function(e){
		paginaDireita();
	});
	jQuery('.trilha').live('swiperight', function(e){
		paginaEsquerda();
	});
	jQuery('.trilha .nav-next').live('click', function(e) {
		paginaDireita();
	});	
	jQuery('.trilha .nav-back').live('click', function(e) {
		paginaEsquerda();
	});
}

function paginaDireita() {
	trilha = jQuery('div.trilha:visible');
	if(trilha.next('.trilha').length){
		trilha.hide().next('.trilha').show();
	}	
}

function paginaEsquerda() {
	trilha = jQuery('div.trilha:visible');
	if(trilha.prev('.trilha').length) {
		trilha.hide().prev('.trilha').show();
	}
}

function setupVouNaoVou() {
	jQuery('a.btn-vo').click(function(event) {
		event.preventDefault();
		link = jQuery(this);
		linha = link.parent().parent();
		linha.addClass('load');
		palestraId = linha.find('input[type=hidden]').val();
		if (linha.hasClass('active')) {
			jQuery.get('/schedules/uncheck', { 'palestra': palestraId }, function(data) {
				jQuery('div.linha').find('input[value='+palestraId+']').parent().removeClass('active')
				linha.removeClass('load');
			}, 'json');
		} else {
			jQuery.get('/schedules/check', { 'palestra': palestraId }, function(data) {
				jQuery('div.linha').find('input[value='+palestraId+']').parent().addClass('active')
				linha.removeClass('load');
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