//pegando imputs
pega_imputs();

//aplicando velocidades e colizoes
aplica_velocidade();

//fazendo o timer do coyote
coyote_time();

//checando as minhas colizoes
checa_colizao();

//tempo invencivel
invencible_time();

//maquina de estados
estado();

//efeitos lerps
efeito_mola_lerp();
efeito_branco_lerp();

//reiniciando o jogo
if (keyboard_check_pressed(ord("R")) && reseta_uma_vez)
{
    cria_transicao_inicia();
    reseta_uma_vez = false;
}

//alternando tela cheia
if (keyboard_check_pressed(vk_f11)) window_set_fullscreen(!window_get_fullscreen());

