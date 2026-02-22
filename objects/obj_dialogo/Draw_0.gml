draw_self();

if (!pode_desenhar) exit;

draw_set_font(fnt_pixel);

var _marg = 2;
var _x = x - sprite_width / 2 + _marg;
var _y = y - sprite_height / 2 + _marg;
var _larg = sprite_width - _marg;

// Criando meu texto do scribble
var _txt = scribble(texto);
// Minha fonte
_txt.starting_format("fnt_pixel", c_white);
 // Ajustando a escala
_txt = _txt.scale(0.1);
 // Fazendo o texto caber na caixa
_txt.wrap(_larg);
 // Desenhando o texto do scribble
_txt.draw(_x, _y, escrevente);

draw_set_font(-1);