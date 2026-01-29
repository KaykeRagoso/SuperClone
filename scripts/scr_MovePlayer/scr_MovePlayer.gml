// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function scr_MovePlayer(){
/// Step Event do Player

// --- Velocidade ---
var move_spd = carregando ? spd_caixa : spd_max;

// --- Input combinando teclado (setas + WASD) e joystick ---
hspd = keyboard_check(vk_right) - keyboard_check(vk_left) 
          + keyboard_check(ord("D")) - keyboard_check(ord("A"));

vspd = keyboard_check(vk_down) - keyboard_check(vk_up) 
          + keyboard_check(ord("S")) - keyboard_check(ord("W"));

// Joystick (considerando joystick 0, o primeiro conectado)
var _deviceControl = 0;
if (gamepad_is_connected(_deviceControl)) {
    hspd += gamepad_axis_value(_deviceControl, gp_axislh);
    vspd += gamepad_axis_value(_deviceControl, gp_axislv);
}

// Normaliza para não andar mais rápido na diagonal
var len = sqrt(hspd*hspd + vspd*vspd);
if (len != 0) {
    hspd /= len;
    vspd /= len;
}

// --- Colisão com paredes ---
var can_move_x = !place_meeting(x + hspd * move_spd, y, obj_Block);
var can_move_y = !place_meeting(x, y + vspd * move_spd, obj_Block);

// --- Colisão com caixas (só quando não está carregando) ---
if (!carregando) {
    if (place_meeting(x + hspd * move_spd, y, obj_Box)) can_move_x = false;
    if (place_meeting(x, y + vspd * move_spd, obj_Box)) can_move_y = false;
}

// --- Aplicar movimento ---
if (can_move_x) x += hspd * move_spd;
if (can_move_y) y += vspd * move_spd;

// --- Direção olhando (prioriza teclado, mas funciona com joystick também) ---
if (hspd > 0) dir = 0;
else if (hspd < 0) dir = 180;
else if (vspd < 0) dir = 90;
else if (vspd > 0) dir = 270;

// --- Detectar caixa próxima ---
var box_to_pick = noone;
var nearest_dist = 999;

for (var i = 0; i < instance_number(obj_Box); i++) {
    var box = instance_find(obj_Box, i);
    if (!box.carregar) {
        var d = point_distance(x, y, box.x, box.y);
        if (d <= 48 && d < nearest_dist) {
            nearest_dist = d;
            box_to_pick = box;
        }
    }
}

// --- Pegar / Soltar caixa ---
if (keyboard_check_pressed(vk_space) || (gamepad_is_connected(_deviceControl) && gamepad_button_check_pressed(_deviceControl, gp_face1))) {
    if (!carregando && box_to_pick != noone) {
        // Começa a carregar a caixa
        carregando = true;
        carregando_caixa = box_to_pick;

        box_to_pick.carregar = true;
        box_to_pick.carrego = id;

    } else if (carregando) {
        // Posição tentativa de drop
        var drop_x = x + lengthdir_x(16 * 3, dir);
        var drop_y = y + lengthdir_y(16 * 3, dir);

        // Verifica se a caixa caberia ali
        if (!place_meeting(drop_x, drop_y, obj_Block)) {
            // Solta a caixa
            carregando_caixa.x = drop_x;
            carregando_caixa.y = drop_y;

            carregando_caixa.carregar = false;
            carregando_caixa.carrego = noone;

            carregando_caixa = noone;
            carregando = false;
        }
    }
}

// --- Caixa segue o player enquanto carregando ---
if (carregando && carregando_caixa != noone) {
    carregando_caixa.x = x;
    carregando_caixa.y = y - 16;
}
var porta = instance_place(x, y, obj_Door);

if (porta != noone
&& !obj_Transicao.fading_out
&& !obj_Transicao.fading_in) {

    obj_Transicao.target_room = porta.room_destino;
    obj_Transicao.spawn_x = porta.spawn_x;
    obj_Transicao.spawn_y = porta.spawn_y;
    obj_Transicao.has_spawn = true;

    obj_Transicao.fading_out = true;
}

}