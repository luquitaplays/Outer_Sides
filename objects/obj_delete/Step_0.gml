var _no_botao = position_meeting(mouse_x, mouse_y, id);
var _aperta = mouse_check_button_pressed(mb_left);

if (_no_botao)
{
    image_alpha = lerp(image_alpha, 1, 0.1);
    
    if (_aperta && file_exists("Save.json"))
    {
        file_delete("Save.json");
        game_end();
    }
}
else 
{
    image_alpha = lerp(image_alpha, 0.7, 0.1); 
}