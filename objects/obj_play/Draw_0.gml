draw_self();

draw_set_font(fnt_pixel);

draw_set_halign(1);
draw_set_valign(1);

var _c1 = c_black;
draw_text_transformed_colour(x, y, "Play", 0.1, 0.1, image_angle, _c1, _c1, _c1, _c1, image_alpha);

draw_set_font(-1);

draw_set_halign(-1);
draw_set_valign(-1);