//iniciando variaveis do efeito mola
function inicia_efeito_mola()
{
	//variaveis de tamanho
	xscale = 1;
	yscale = 1;	
}
//setando variaveis do efeito mola
function efeito_set_mola(_xsacale = 0.8, _yscale = 1.2)
{
	//variaveis de tamanho
	xscale = _xsacale;
	yscale = _yscale;
}
//diminuindo ou aumentando efeito mola com lerp
function efeito_mola_lerp(_qtd = 0.1)
{
	//falando para a escala diminuir
	xscale = lerp(xscale, 1, _qtd);
	yscale = lerp(yscale, 1, _qtd);
}
//desenhando efeito mola
function desenha_efeito_mola(_direcao = 0)
{
	//desenhando a escala com a direçao se nessecerio
	draw_sprite_ext(sprite_index, image_index, x, y, xscale * _direcao, yscale, image_angle, image_blend, image_alpha);
}