if (place_meeting(x, y, colizions))
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
        
        //falando pra parar de desenhar
        box.pode_desenhar = false;
        
        //se o lerp chegou ao "fim" destroi a caixa
        if (box.y >= box.ystart - 0.1) instance_destroy(box);
    }
}