jQuery(document).ready(function(){
	document.addEventListener('touchstart', function(event) {
		curX = event.touches[0].pageX;
		curY = event.touches[0].pageY;
		//jQuery('.console').val(curX + " " + curY);
	}, false);
	distance = 100000;

	bindSwipe('.primeiro-dia');
	bindSwipe('.segundo-dia');
	bindSwipe('.terceiro-dia');
	
	jQuery('.linha:not(.nao-clicavel)').click(function() {
		linha = jQuery(this)
		linha.addClass('load');
		palestraId = linha.find('input[type=hidden]').val();
		if (linha.hasClass('active')) {
			jQuery.get('/schedules/uncheck', { 'palestra': palestraId }, function(data) {
				linha.removeClass('active').removeClass('load');
			}, 'json');
		} else {
			jQuery.get('/schedules/check', { 'palestra': palestraId }, function(data) {
				linha.addClass('active').removeClass('load');
			}, 'json');
		}
	});
	
	jQuery('div.menu a').each(function() {
		jQuery(this).click(function() {
			jQuery('div.menu a').removeClass('active');
			jQuery('div.dia').hide();
			jQuery(this).addClass('active');
			diaSelecionado = jQuery(this).attr('title');
			jQuery('div.'+diaSelecionado).show();
		});
	});
});

function bindSwipe(dia) {
	jQuery(dia+' .trilha').bind('swipeleft click', function(e){
		trilha = jQuery(this);
		if(trilha.next(dia+' .trilha').length){
			trilha.hide().next(dia+' .trilha').show();
		}
	});
	jQuery(dia+' .trilha').bind('swiperight click', function(e){
		trilha = jQuery(this);
		if(trilha.prev(dia+' .trilha').length) {
			trilha.hide().prev(dia+' .trilha').show();
		}
	});
}


/*
jQuery(document).ready(function(){
	jQuery('table td').click(function(){ 
		elemento = jQuery(this);					
		posicao_novo = jQuery(this).position().left;
		tamanho_novo = posicao_novo + jQuery(this).width();
		if(!elemento.hasClass('proibido') && !elemento.hasClass('escolhido')){
			jQuery('table .escolhido').each(function(){
				posicao = jQuery(this).position().left;
				tamanho = posicao + jQuery(this).width();
				if((posicao <= posicao_novo && posicao_novo <= tamanho) ||
					(posicao <= tamanho_novo && tamanho_novo <= tamanho)){
					elemento.addClass('proibido');
					jQuery(this).addClass('proibido');
				}
			});
			if(!elemento.hasClass('proibido'))
				elemento.toggleClass('escolhido'); 
		}else{
			elemento.removeClass('proibido'); 
			elemento.removeClass('escolhido'); 
		}
	});

	jQuery('ul li a').click(function(){
		jQuery('ul li a').removeClass('active');						
		jQuery(this).addClass('active');
	});
});
*/
