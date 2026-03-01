//variaveis

sufocado = false;

vel = 1;
velh = 0;
velv = 0;

mc_vel_muda_dir_ar = 0.04;
mc_vel_muda_dir = 0.3;
vel_muda_dir = mc_vel_muda_dir;

right = 0;
left = 0;

subindo = false;

jump = 0;
forca_pulo = 3.3;
mc_forca_mola = forca_pulo * 1.6;
mc_forca_mola_h = forca_pulo * 1.6;
mc_grav = 0.15;
grav = mc_grav;

max_velv = 12;

global.normal = true;

coyote_limite = 8;
coyote_timer = coyote_limite;

corner_limite = 6;
chao = 0;
teto = 0;

mola = false;
mola_diagonal = false;

var _tile = layer_tilemap_get_id("tl_chao");
colizions = [obj_chao_all, obj_chao_no, _tile, obj_passagem];
colizions_dano = [obj_espinho_no, obj_espinho_all];
colizions_sufocado = [obj_parede_switch_p1, obj_parede_switch_p2];

//transicao de sprites
transicao_pulo_pra_queda = [spr_player_jump_fall, spr_player_fall];

transicao_atual = transicao_pulo_pra_queda;
spr_atual = 0;

//iniciando efeitos scrible
scribble_anim_wave(0.5, 1.5, 0.15);
scribble_anim_wheel(0.2, 1.2, 0.15);
scribble_anim_jitter(0.8, 1.2, 0.1);
scribble_anim_pulse(0.3, 0.1);
scribble_anim_shake(1, 0.1);
scribble_anim_wobble(30, 0.2);

//se ele for o player n jogavel
if (not_playable)
{
    sprite_index = spr;
}
else //se ele for o player normal
{
    //iniciando efeitos
    inicia_efeito_mola();
    inicia_efeito_branco();
}

pega_imputs = function()
{
    right = keyboard_check(vk_right) || keyboard_check(ord("D"));
    left = keyboard_check(vk_left) || keyboard_check(ord("A"));
    
    if (room != rm_cut_cene) // se eu estiver na cut cene eu n pulo
    {
        jump = keyboard_check_pressed(vk_space);
        jump_r = keyboard_check_released(vk_space);
    }
}

checa_colizao = function()
{
    chao = place_meeting(x, y + 1, colizions);
    teto = place_meeting(x, y + sign(velv), colizions); 
    
    dano = place_meeting(x, y, colizions_dano);
    
    //paredes
    parede_dir = place_meeting(x + 1, y, colizions);
    parede_esq = place_meeting(x - 1, y, colizions);
    
    mola = place_meeting(x, y, obj_mola);
    mola_diagonal = place_meeting(x, y, obj_mola_diagonal);
    
    sufocado = place_meeting(x, y, colizions_sufocado);
}

transicao_de_sprites = function()
{
    troca_sprite(transicao_atual[spr_atual]);
    
    if (end_animation() && spr_atual < array_length(transicao_atual) - 1)
    {
        spr_atual += 1;
    }
}

mudando_transicao_de_sprites = function(_array)
{
    transicao_atual = _array;
}

coyote_time = function()
{
    //se eu n to no chao
    if (!chao) 
    {
        //liga o coyote timer
        coyote_timer--;
    }
    else coyote_timer = coyote_limite; // se eu encostei zera
}

movimento = function()
{
    var _velh = (right - left) * vel;
    
    // Se eu estou no chão, eu passo direto o valor do _velh para o velh
    if (chao)
    {
        velh = _velh;
    }
    else
    {
        // Eu mudo de pouquinho em pouquinho o valor do velh com base no _velh
        velh = lerp(velh, _velh, vel_muda_dir);
    }
    
    if (chao)
    {
        velv = 0;
        y = round(y);
        
        if (jump)
        {
            velv = -forca_pulo;
            audio_play_sound(snd_pulo, 0, false);
        }
    }
    else 
    {
        if (estado == estado_desliza_parede)
        {
            if(jump)
            {
                velv = -forca_pulo + 0.3;
                velh = 1.8 * -dir;
                audio_play_sound(snd_pulo, 0, false);
            }
        }
        
    	velv += grav;
    }
    
    if (place_meeting(x, y + velv, colizions)) y = round(y);
    
    //fazendo o meu velver estar abaixo do limite
    velv = clamp(velv, -max_velv, max_velv);
}

corner_correction = function()
{
    //CORNER CORRECTION
    var _corner_correction = false;
    
    //se encostou no teto enquanto tava subindo
    if (velv < 0)
    {
        //direita
        if (velh >= 0)
        {
            for (var i = 0; i < corner_limite; i++)
            {
                var _livre_r = !place_meeting(x + i, y + velv, colizions);
                
                if (_livre_r)
                {
                    //corner correction
                    x += i;
                    //falando que fiz o corner correction
                    _corner_correction = true;
                    //sai do loop
                    break;
                }
            }
        }
        //esquerda
        if (velh <= 0)
        {
            for (var i = 0; i < corner_limite; i++)
            {
                var _livre_l = !place_meeting(x - i, y + velv, colizions);
                
                if (_livre_l)
                {
                    //corner correction
                    x -= i;
                    //falando que fiz o corner correction
                    _corner_correction = true;
                    //sai do loop
                    break;
                }
            }
        }
    }
    
    if (!_corner_correction)
    {
        //zerando velv
        velv = 0;
    }
    else 
    {
        _corner_correction = false;
    }
}

grav_op = function()
{
    if (chao) velv = 0;
    else velv += grav;
}

aplica_velocidade = function()
{
    move_and_collide(velh, 0, colizions);
    move_and_collide(0, velv, colizions);
}

//esse função serve apenas para quando trocar a sprite trocar para o começo dela !
troca_sprite = function(_spr = spr_player_idle)
{
    if (sprite_index != _spr)
    {
        sprite_index = _spr;
        //do começo
        image_index = 0;
    }
}

checa_dir = function()
{
    if (velh > 0) dir = 1;
    else if (velh < 0) dir = -1;
}

pega_frag = function()
{
    var _frag = instance_place(x, y, obj_frag_no);
    if (_frag != noone)
    {
        instance_destroy(_frag);
        audio_play_sound(snd_pickup, 0 ,false);
    }
}


//------------------------------------------------
//STATE MACHINE-----------------------------------
//------------------------------------------------


estado_i_lose_control = function()
{
    
}

estado_parado = function()
{
    troca_sprite(spr_player_idle);
    
    movimento();
    checa_dir();
    
    if (right != left)
    {
        estado = estado_andando;
    }
    
    if (!chao)
    {
        estado = estado_caindo;
        
        spr_atual = 0;
    }
    
    if (jump)
    {
        estado = estado_pulando;
        efeito_set_mola(0.8, 1.2);
    }
    
    if (mola)
    {
        estado = estado_mola;
        efeito_set_mola(0.8, 1.2);
        
        velv = -mc_forca_mola;
    }
    
    if (mola_diagonal)
    {
        estado = estado_mola_diagonal;
        efeito_set_mola(0.8, 1.2);
        
        velv = -mc_forca_mola;
    }
    
    if (dano)
    {
        estado = estado_dano;
        velv = -2;
        velh = 1 * -dir;
        efeito_set_branco_cor(c_red);
        efeito_set_branco(image_alpha);
    }
}

estado_andando = function()
{
    troca_sprite(spr_player_walk);
    
    movimento();
    checa_dir();
    
    if (velh == 0)
    {
        estado = estado_parado;
    }
    
    if (!chao && !jump)
    {
        estado = estado_caindo;
        
        spr_atual = 0;
    }
    
    if (jump)
    {
        estado = estado_pulando;
        efeito_set_mola(0.8, 1.2);
        
        //se por algum motivo bugou
        if (!chao)
        {
            velv = -forca_pulo;
            audio_play_sound(snd_pulo, 0, false);
        }
    }
    
    if (mola)
    {
        estado = estado_mola;
        efeito_set_mola(0.8, 1.2);
        
        velv = -mc_forca_mola;
    }
    
    if (mola_diagonal)
    {
        estado = estado_mola_diagonal;
        efeito_set_mola(0.8, 1.2);
        
        velv = -mc_forca_mola;
    }
    
    if (dano)
    {
        estado = estado_dano;
        velv = -2;
        velh = 1 * -dir;
        efeito_set_branco_cor(c_red);
        efeito_set_branco(image_alpha);
    }
}

estado_pulando = function()
{
    troca_sprite(spr_player_jump);
    
    movimento();
    checa_dir();
    
    //se eu soltar o botao faz eu ir mais baixo
    if (jump_r)
    {
        velv /= 2;
    }
    
    //se eu encostei no teto
    if (teto)
    {
        //uzando o corner_correction
        corner_correction();
    }
    
    if (velv >= 0)
    {
        estado = estado_caindo;
        
        spr_atual = 0;
    }
    
    if (dano)
    {
        estado = estado_dano;
        velv = -2;
        velh = 1 * -dir;
        efeito_set_branco_cor(c_red);
        efeito_set_branco(image_alpha);
    }
}

estado_caindo = function()
{
    transicao_de_sprites();
    
    movimento();
    checa_dir();
    
    //se for assima de 1 e pulei
    if (coyote_timer > 0 && jump)
    {
        //pula de novo
        velv = -forca_pulo;
        
        estado = estado_pulando;
        efeito_set_mola(0.8, 1.2);
        audio_play_sound(snd_pulo, 0, false);
        
        coyote_timer = 0;
    }
    
    if (chao)
    {
        estado = estado_parado;
        efeito_set_mola(1.2, 0.8);
    }
    
    if (mola)
    {
        estado = estado_mola;
        efeito_set_mola(0.8, 1.2);
        
        velv = -mc_forca_mola;
    }
    
    if (mola_diagonal)
    {
        estado = estado_mola_diagonal;
        efeito_set_mola(0.8, 1.2);
        
        velv = -mc_forca_mola;
    }
    
    if (dano)
    {
        estado = estado_dano;
        velv = -2;
        velh = 1 * -dir;
        efeito_set_branco_cor(c_red);
        efeito_set_branco(image_alpha);
    }
    
    if ((parede_dir && dir == 1) || (parede_esq && dir == -1))
    {
        estado = estado_desliza_parede;
        velv = 0;
    }
}

//dezlizando
estado_desliza_parede = function()
{
    troca_sprite(spr_player_wall_slide);
    
    movimento();
    
    grav = 0;
    
    velv += 0.02;
    
    if (jump)
    {
        estado = estado_wall_jump;
        efeito_set_mola(0.8, 1.2);
        
        grav = mc_grav;
    }
    
    if (!parede_dir && !parede_esq)
    {
        estado = estado_caindo;
        
        grav = mc_grav;
    }
    
    if (chao)
    {
        estado = estado_parado;
        
        grav = mc_grav;
    }
    
    if (dano)
    {
        estado = estado_dano;
        velv = -2;
        velh = 1 * -dir;
        efeito_set_branco_cor(c_red);
        efeito_set_branco(image_alpha);
        
        grav = mc_grav;
    }
}

//pulando pro wall jump
estado_wall_jump = function()
{
    troca_sprite(spr_player_wall_jump);
    
    movimento();
    checa_dir();
    
    vel_muda_dir = mc_vel_muda_dir_ar;
    
    //se eu encostei no teto
    if (teto)
    {
        //uzando o corner_correction
        corner_correction();
    }
    
    if ((parede_dir && dir == 1) || (parede_esq && dir == -1))
    {
        estado = estado_desliza_parede;
        velv = 0;
        
        vel_muda_dir = mc_vel_muda_dir;
    }
    
    if (chao)
    {
        efeito_set_mola(1.5, 0.7);
        estado = estado_parado;
        vel_muda_dir = mc_vel_muda_dir;
    }
    
    if (mola)
    {
        estado = estado_mola;
        efeito_set_mola(0.8, 1.2);
        
        velv = -mc_forca_mola;
        
        vel_muda_dir = mc_vel_muda_dir;
    }
    
    if (mola_diagonal)
    {
        estado = estado_mola_diagonal;
        efeito_set_mola(0.8, 1.2);
        
        velv = -mc_forca_mola;
        
        vel_muda_dir = mc_vel_muda_dir;
    }
    
    if (dano)
    {
        estado = estado_dano;
        velv = -2;
        velh = 1 * -dir;
        efeito_set_branco_cor(c_red);
        efeito_set_branco(image_alpha);
        
        vel_muda_dir = mc_vel_muda_dir;
    }
}

estado_mola = function()
{
    troca_sprite(spr_player_jump);
    
    movimento();
    
    checa_dir();
    
    //se eu encostei no teto
    if (teto)
    {
        //uzando o corner_correction
        corner_correction();
    }
    
    if (velv >= 0)
    {
        estado = estado_caindo;
        
        spr_atual = 0;
    }
    
    if (dano)
    {
        estado = estado_dano;
        velv = -2;
        velh = 1 * -dir;
        efeito_set_branco_cor(c_red);
        efeito_set_branco(image_alpha);
    }
}

estado_mola_diagonal = function()
{
    troca_sprite(spr_player_jump);
    
    movimento();
    
    checa_dir();
    
    velh = -mc_forca_mola_h;
    
    //se eu encostei no teto
    if (teto)
    {
        //uzando o corner_correction
        corner_correction();
    }
    
    if (velv >= 0)
    {
        estado = estado_mola_diagonal_cai;
        
        spr_atual = 0;
    }
    
    if (dano)
    {
        estado = estado_dano;
        velv = -2;
        velh = 1 * -dir;
        efeito_set_branco_cor(c_red);
        efeito_set_branco(image_alpha);
    }
}

estado_mola_diagonal_cai = function()
{
    transicao_de_sprites();
    
    movimento();
    checa_dir();
    
    velh = -mc_forca_mola_h;
    
    if (chao)
    {
        estado = estado_parado;
        efeito_set_mola(1.2, 0.8);
    }
    
    if (mola)
    {
        estado = estado_mola;
        efeito_set_mola(0.8, 1.2);
        
        velv = -mc_forca_mola;
    }
    
    if (mola_diagonal)
    {
        estado = estado_mola_diagonal;
        efeito_set_mola(0.8, 1.2);
        
        velv = -mc_forca_mola;
    }
    
    if (dano)
    {
        estado = estado_dano;
        velv = -2;
        velh = 1 * -dir;
        efeito_set_branco_cor(c_red);
        efeito_set_branco(image_alpha);
    }
    
    if ((parede_dir && dir == 1) || (parede_esq && dir == -1))
    {
        estado = estado_desliza_parede;
        velv = 0;
    }
}

estado_dano = function()
{
    troca_sprite(spr_player_jump);
    grav_op();
    
    //se eu encostei no teto
    if (teto)
    {
        //uzando o corner_correction
        velv = 0;
    }
    
    if (!global.transicao)
    {
        cria_transicao_inicia(room);
        treme_a_tela(10);
    }
}

//criando o estado antes de "uzalo"
estado = estado_parado;