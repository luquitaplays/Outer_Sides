//variaveis

global.normal = true;
global.vidas = 0;
global.quebra_espelho = false;

function muda_room()
{
    room = rm_cut_cene_2;
}

function muda_room_2()
{
    room = rm_final;
    global.room_atual = rm_final;
    salvar_jogo();
}