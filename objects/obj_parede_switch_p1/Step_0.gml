//se ela ta vazio
if (ativado)
{
    //muda o desenho
    image_index = 1;
    
    if (instance_exists(obj_player) && instance_exists(obj_player_in))
    {
        //atualizando colizoes
        obj_player.colizions = atualiza_colisao(obj_player.colizions, id, false);
        obj_player_in.colizions = atualiza_colisao(obj_player_in.colizions, id, false);
    }
}
else //se ele ta parede
{
    //muda o desenho
    image_index = 0;
    
    if (instance_exists(obj_player) && instance_exists(obj_player_in))
    {
        //atualizando colizoes
        obj_player.colizions = atualiza_colisao(obj_player.colizions, id, true);
        obj_player_in.colizions = atualiza_colisao(obj_player_in.colizions, id, true);
    }
}