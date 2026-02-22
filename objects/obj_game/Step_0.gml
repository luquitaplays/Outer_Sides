//se od jogadores não existirem saia !
if (!instance_exists(obj_player) || !instance_exists(obj_player_in)) exit;

//alternando mundos
if (keyboard_check_pressed(vk_tab))
{
    global.normal = !global.normal;
}

if (room == rm_cut_cene_2) exit;

//reiniciando o jogo
if (keyboard_check_pressed(ord("R")) && !global.transicao)
{
    cria_transicao_inicia(room);
}

//passando de fase
if (!instance_exists(obj_frag) && !global.transicao && passa_uma_vez && room != rm_reception)
{
    var _proxima_room = room_next(room);
    cria_transicao_inicia(_proxima_room);
    global.room_atual = _proxima_room;
    salvar_jogo();
    passa_uma_vez = false;
}

//alternando tela cheia
if (keyboard_check_pressed(vk_f11))
{
    window_set_fullscreen(!window_get_fullscreen());
}
