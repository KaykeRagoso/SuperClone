#region HudLife
var life_width  = 36;
var life_height = 16;
var lifeScale   = 1.5;

var spacing     = 6;   // espaço após os corações
var item_space  = 4;   // espaço entre os itens

// --- Corações ---
for (var i = 0; i < max_life; i++) {
    var _x = life_offset_x + i * (life_width * lifeScale);
    var _y = life_offset_y;

    draw_sprite_ext(
        sprt_Coracao,
        0,
        _x,
        _y,
        lifeScale,
        lifeScale,
        0,
        c_white,
        life_alpha[i]
    );
}

// --- Posição final dos corações ---
var end_x = life_offset_x + max_life * (life_width * lifeScale);

// --- Item 1 ---
draw_sprite_ext(
    sprt_Item,
    image_index,
    end_x + spacing,
    life_offset_y,
    lifeScale,
    lifeScale,
    0,
    c_white,
    1
);

// --- Item 2 ---
draw_sprite_ext(
    sprt_Item,
    image_index,
    end_x + spacing + (sprite_get_width(sprt_Item) * lifeScale) + item_space,
    life_offset_y,
    lifeScale,
    lifeScale,
    0,
    c_white,
    1
);
#endregion
