var _p1 = instance_place(x, y, obj_player);
var _p2 = instance_place(x, y, obj_player_in);

if (_p1 || _p2)
{
    image_speed = 1;
}

if (end_animation())
{
    image_speed = 0;
    image_index = 0;
}