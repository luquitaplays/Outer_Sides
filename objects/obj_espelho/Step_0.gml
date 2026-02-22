if (global.quebra_espelho)
{
    image_index = 1;
    treme_a_tela(20);
    audio_play_sound(snd_quebra, 0, false);
    global.quebra_espelho = false;
}