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
		if (Math.abs(variacao) > 100)
			jQuery(document).touchend();
	}, false);
	document.addEventListener('touchend', function(event) {
		trilhaVisivel.offset({ top: this.top, left: 0 })
		inicio = 0;
	}, false);
	
	bindSwipe('.dia');
	setupVouNaoVou();
	exibirPalestraAtual();
	jQuery('.menu a').click(function(e){
		e.preventDefault();
		jQuery('body').load(this.href);
	});
});

function bindSwipe(dia) {
	jQuery(dia+' .trilha').live('swipeleft', function(e){
		trilha = jQuery(this);
		if(trilha.next(dia+' .trilha').length){
			trilha.hide().next(dia+' .trilha').show();
		}
	});
	jQuery(dia+' .trilha').live('swiperight', function(e){
		trilha = jQuery(this);
		if(trilha.prev(dia+' .trilha').length) {
			trilha.hide().prev(dia+' .trilha').show();
		}
	});
}

function setupVouNaoVou() {
	jQuery('a.btn-vo').click(function() {
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