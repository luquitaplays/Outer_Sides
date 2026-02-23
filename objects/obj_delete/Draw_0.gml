draw_self();

draw_set_font(fnt_pixel);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

var _c1 = c_white;
draw_text_transformed_colour(x - 12, y - 6, "Sair e \ndeletar \nSave ?", 0.1, 0.1, image_angle, _c1, _c1, _c1, _c1, image_alpha);

draw_set_font(-1);

draw_set_halign(-1);
draw_set_valign(-1);