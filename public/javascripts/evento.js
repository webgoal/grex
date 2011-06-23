jQuery(document).ready(function(){
	bindSwipe('.dia');
	setupVouNaoVou();
	jQuery('.menu a').click(function(e){
		e.preventDefault();
		jQuery('body').load(this.href);
	});
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