var _no_botao = position_meeting(mouse_x, mouse_y, id);
var _aperta = mouse_check_button_pressed(mb_left);

if (_no_botao)
{
    image_index = 1;
    
    if (_aperta && !global.transicao)
    {
        audio_play_sound(snd_skip, 0, false);
        
        var _prox = room_next(room);
        cria_transicao_inicia(_prox);
        global.room_atual = _prox;
        salvar_jogo();
    }
}
else 
{
    image_index = 0;
}