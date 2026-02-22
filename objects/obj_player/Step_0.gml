if (!global.normal)
{
    image_speed = 0;
    image_alpha = lerp(image_alpha, 0.3, 0.1);
    exit;
}
else 
{
    image_speed = 1;
    image_alpha = lerp(image_alpha, 1, 0.1);
}

if (not_playable) exit;

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
