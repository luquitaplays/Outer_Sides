var _p1 = instance_place(x, y, obj_player);
var _p2 = instance_place(x, y, obj_player_in);

var _p1_exists = instance_exists(obj_player);
var _p2_exists = instance_exists(obj_player_in);

timer--;

if (timer > 0) exit;

if (_p1 != noone && _p2_exists && !ativado)
{
    global.normal = !global.normal;
    
    _p1.x = obj_player_in.x;
    _p1.y = obj_player_in.y;
    
    obj_player_in.x = x;
    obj_player_in.y = y;
    
    obj_player_in.coyote_timer = 0;
    
    audio_play_sound(snd_troca, 0, false);
    
    timer = espera_timer;
}

if (_p2 != noone && _p1_exists && !ativado)
{
    global.normal = !global.normal;
    
    _p2.x = obj_player.x;
    _p2.y = obj_player.y;
    
    obj_player.x = x;
    obj_player.y = y;
    
    obj_player.coyote_timer = 0;
    
    audio_play_sound(snd_troca, 0, false);
    
    timer = espera_timer;
}

if (!_p1 && !_p2)
{
    ativado = false;
}
else 
{
	ativado = true;
}