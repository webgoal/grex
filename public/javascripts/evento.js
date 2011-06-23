jQuery(document).ready(function(){
	bindSwipe('.dia');
	setupVouNaoVou();
	exibirPalestraAtual();
});

function bindSwipe(dia) {
	jQuery(dia+' .trilha').bind('swipeleft', function(e){
		trilha = jQuery(this);
		if(trilha.next(dia+' .trilha').length){
			trilha.hide().next(dia+' .trilha').show();
		}
	});
	jQuery(dia+' .trilha').bind('swiperight', function(e){
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
				linha.removeClass('active');
				linha.removeClass('load');
			}, 'json');
		} else {
			jQuery.get('/schedules/check', { 'palestra': palestraId }, function(data) {
				linha.addClass('active');
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