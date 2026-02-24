metodo_generico = function(_player)
{
    with(_player)
    {
        estado = estado_i_lose_control;
        velh = 0;
        sprite_index = spr_player_idle;
        
        var _placa = instance_create_layer(x, y, "Level", obj_placa_cutcene);
        var _skip = instance_create_layer(296, 16, "Dialogo", obj_skip);
        if (instance_exists(obj_seta)) instance_destroy(obj_seta);
    }
    
    instance_destroy();
}