timer--;

texto = array[inndice];

if (global.normal)
{
    x = 64;
}
else 
{
    x = 264;
}

if (timer > 0 && pode)
{
    if (!instance_exists(box))
    {
        //setando variaveis e criando a caixa
        box = instance_create_layer(x, y, "Dialogo", obj_dialogo);
        box.texto = texto;
        box.image_alpha = 0.7;
        box.image_xscale = 0;
        box.image_yscale = 0;
        box.x = x;
        box.y = y;
    }
    else 
    {
        //lerpzando geral
        box.image_xscale = lerp(box.image_xscale, 10, 0.1);
        box.image_yscale = lerp(box.image_yscale, 5, 0.1);
        box.y = lerp(box.y, box.ystart - 43, 0.1);
        box.x = x;
        
        //no "fim" do lerp pode desenhar
        if (box.y <= box.ystart - 42) box.pode_desenhar = true;
    }
}
else 
{
    if (instance_exists(box))
    {
        //lerpzando o povo
        box.image_xscale = lerp(box.image_xscale, 0, 0.1);
        box.image_yscale = lerp(box.image_yscale, 0, 0.1);
        box.y = lerp(box.y, box.ystart, 0.1);
        box.x = x;
        
        //falando pra parar de desenhar
        box.pode_desenhar = false;
        
        //se o lerp chegou ao "fim" destroi a caixa
        if (box.y >= box.ystart - 0.1)
        {
            instance_destroy(box);
            timer = espera_timer;
            if (inndice < array_length(array) - 1)
            {
                inndice++
            }
            else 
            {
                ativa_timer_final = true;
                pode = false;
            }
        }
    }
}

if (ativa_timer_final)
{
    timer_final--;
    if (timer_final <= 0)
    {
        instance_destroy();
        with (obj_player) 
        {
            var _prox_rm = room_next(room);
            cria_transicao_inicia(_prox_rm);
            global.room_atual = _prox_rm;
            salvar_jogo();
        }
    }
}