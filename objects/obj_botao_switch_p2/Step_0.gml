//se ta colidindo
if (place_meeting(x, y, colizoes))
{
    //e n ta ativado. se n tava abaixado
    if (!ativado)
    {
        //ativado = true. to abaixado
        ativado = true;
    }
}
else //se n ta colidindo
{
    //e ta ativado. se n ta levantado
    if (ativado)
    {
        //ativado = false. to levantado
        ativado = false;
    }
}

//se ta no tab
if (!global.normal)
{
    //fica alterado
    image_alpha = lerp(image_alpha, 0.3, 0.1);
}
else //se ta no tab
{
    //fica normal
    image_alpha = lerp(image_alpha, 1, 0.1);	
}

//se ele ta abaixado
if (ativado)
{
    //imagem abaixada
    image_index = 1;
    //se ele ta abaixado...
    with (obj_parede_switch_p2)
    { 
        //invertendo a veriavel dele
        ativado = !comeca_vazio;
    }
}
else //se ele ta em pé
{
    //imagem de pé
    image_index = 0;
    //se ele ta em pé...
    with (obj_parede_switch_p2)
    { 
        //invertendo a veriavel dele
        ativado = comeca_vazio;
    }
}