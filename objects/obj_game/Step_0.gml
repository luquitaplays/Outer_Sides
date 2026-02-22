//se od jogadores não existirem saia !
if (!instance_exists(obj_player) || !instance_exists(obj_player_in)) exit;

//alternando mundos
if (keyboard_check_pressed(vk_tab))
{
    global.normal = !global.normal;
}

//reiniciando o jogo
if (keyboard_check_pressed(ord("R")) && reseta_uma_vez)
{
    cria_transicao_inicia(room);
    reseta_uma_vez = false;
}

//alternando tela cheia
if (keyboard_check_pressed(vk_f11))
{
    window_set_fullscreen(!window_get_fullscreen());
}