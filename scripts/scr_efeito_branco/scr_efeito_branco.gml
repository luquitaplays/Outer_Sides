//iniciando variaveis do efeito mola
function inicia_efeito_branco()
{
    cor = c_white;
    brilho_aparece = 0;
	xscale = 1;
	yscale = 1;	
}
//setando variaveis do efeito mola
function efeito_set_branco(_alpha = 1)
{
	//variaveis brilho
	brilho_aparece = _alpha;
}
//funçao pra cor
function efeito_set_branco_cor(_cor = c_white)
{
    cor = _cor;
}
//diminuindo ou aumentando efeito mola com lerp
function efeito_branco_lerp(_qtd = 0.1)
{
	//falando para a escala diminuir
	brilho_aparece = lerp(brilho_aparece, 0, _qtd);
}
//desenhando efeito mola
function desenha_efeito_branco(_direcao = 0)
{
    if (brilho_aparece <= 0.01) return;
    
	//desenhando por cima os efeitos...
    shader_set(sh_efeito_cores);
    draw_sprite_ext(sprite_index, image_index, x, y, xscale * _direcao, yscale, image_angle, cor, brilho_aparece);
    shader_reset();
}