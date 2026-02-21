//Desenhando na guia para não precisar checar a posição de nada
if (escurecer_tudo)
{
    var _larg = view_get_wport(0);
    var _alt  = view_get_hport(0);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _larg, _alt, false);
    draw_set_color(-1);
}