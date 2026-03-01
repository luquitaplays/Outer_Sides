if (not_playable)
{
    draw_self();
    exit;
}

//efeitos

desenha_efeito_mola(dir);
desenha_efeito_branco(dir);

draw_set_font(fnt_pixel);
draw_set_colour(c_black);

if (room == rm_level_1) draw_text_transformed(10, 10, "Level: 1 / 12", 0.1, 0.1, 0);
else if (room == rm_level_2) draw_text_transformed(10, 10, "Level: 2 / 12", 0.1, 0.1, 0);
else if (room == rm_level_3) draw_text_transformed(10, 10, "Level: 3 / 12", 0.1, 0.1, 0);
else if (room == rm_level_4) draw_text_transformed(10, 10, "Level: 4 / 12", 0.1, 0.1, 0);
else if (room == rm_level_5) draw_text_transformed(10, 10, "Level: 5 / 12", 0.1, 0.1, 0);
else if (room == rm_level_6) draw_text_transformed(10, 10, "Level: 6 / 12", 0.1, 0.1, 0);
else if (room == rm_level_7) draw_text_transformed(10, 10, "Level: 7 / 12", 0.1, 0.1, 0);
else if (room == rm_level_8) draw_text_transformed(10, 10, "Level: 8 / 12", 0.1, 0.1, 0);
else if (room == rm_level_9) draw_text_transformed(10, 10, "Level: 9 / 12", 0.1, 0.1, 0);
else if (room == rm_level_10) draw_text_transformed(10, 10, "Level: 10 / 12", 0.1, 0.1, 0);
else if (room == rm_level_11) draw_text_transformed(10, 10, "Level: 11 / 12", 0.1, 0.1, 0);
else if (room == rm_level_12) draw_text_transformed(10, 10, "Level: 12 / 12", 0.1, 0.1, 0);

draw_set_colour(-1);
draw_set_font(-1);