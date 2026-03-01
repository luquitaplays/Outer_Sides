if (global.normal)
{
    image_alpha = lerp(image_alpha, global.tab_min, 0.1);
}
else 
{
    image_alpha = lerp(image_alpha, 1, 0.1);
}