/// Step Event do Player

// --- Velocidade ---
var move_spd = carregando ? spd_caixa : spd_max;

// --- Input ---
var hspd = keyboard_check(vk_right) - keyboard_check(vk_left);
var vspd = keyboard_check(vk_down) - keyboard_check(vk_up);

// --- Colisão com paredes ---
var can_move_x = !place_meeting(x + hspd * move_spd, y, obj_Block);
var can_move_y = !place_meeting(x, y + vspd * move_spd, obj_Block);

// --- Aplicar movimento ---
if (can_move_x) x += hspd * move_spd;
if (can_move_y) y += vspd * move_spd;


// --- Direção olhando ---
if (keyboard_check(vk_right)) dir = 0;
else if (keyboard_check(vk_left)) dir = 180;
else if (keyboard_check(vk_up)) dir = 90;
else if (keyboard_check(vk_down)) dir = 270;

// --- Detectar caixa próxima dentro da zona de interação ---
var box_to_pick = noone;
var nearest_dist = 64;

// Itera todas as caixas
var i;
for (i = 0; i < instance_number(obj_Box); i++) {
    var box = instance_find(obj_Box, i);
    if (!box.carregar) { // só pega caixas não carregadas
        var d = point_distance(x, y, box.x, box.y);
        if (d <= box.interaction_width/2) { // dentro da zona
            if (d < nearest_dist) {
                nearest_dist = d;
                box_to_pick = box;
            }
        }
    }
}

// --- Pegar / Soltar caixa ---
if (keyboard_check_pressed(vk_space)) {

    if (!carregando && box_to_pick != noone) {
        // Começa a carregar a caixa
        carregando = true;
        carregando_caixa = box_to_pick;

        box_to_pick.carregar = true;
        box_to_pick.carrego = id;

    } else if (carregando) {
        // Soltar a caixa na direção olhando
        var drop_x = x + lengthdir_x(16, dir);
        var drop_y = y + lengthdir_y(16, dir);

        carregando_caixa.x = drop_x;
        carregando_caixa.y = drop_y;

        carregando_caixa.carregar = false;
        carregando_caixa.carrego = noone;

        carregando_caixa = noone;
        carregando = false;
    }
}

// --- Caixa segue o player enquanto carregando ---
if (carregando && carregando_caixa != noone) {
    carregando_caixa.x = x;
    carregando_caixa.y = y - 16; // ajusta acima do player
}
