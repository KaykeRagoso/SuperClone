#region HudLife
var hp = life;           // vida atual do player
var hp_max = max_life;   // vida máxima

var life_width = 32;          // largura de cada coração
var life_height = 16;
var lifeScale = 2;

for (var i = 0; i < hp_max; i++) {
    var _x = life_offset_x + i * (life_width * 1);
    var _y = life_offset_y;
    if (i < hp) {
        draw_sprite_ext(sprt_Life, image_index, _x, _y,lifeScale,lifeScale,image_angle,image_blend,image_alpha); // vida cheia
    } else {
        draw_sprite_ext(sprt_Life, image_index, _x, _y,lifeScale,lifeScale,image_angle,image_blend,image_alpha); // vida vazia
    }
}
#endregion
