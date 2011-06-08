jQuery(document).ready(function(){
	document.addEventListener('touchstart', function(event) {
		curX = event.touches[0].pageX;
		curY = event.touches[0].pageY;
		//jQuery('.console').val(curX + " " + curY);
	}, false);
	distance = 100000;
	jQuery('.trilha').bind('swipeleft', function(e){
		trilha = jQuery(this);
		if(trilha.next('.trilha').length){
			trilha.hide();
			trilha.next('.trilha').show();
		}
	});
	jQuery('.trilha').bind('swiperight', function(e){
		trilha = jQuery(this);
		if(trilha.prev('.trilha').length) {
			trilha.hide();
			trilha.prev('.trilha').show();
		}
	});
	
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
});


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
