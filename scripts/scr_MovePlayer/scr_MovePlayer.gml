function scr_MovePlayer() {

    /// --- Velocidade ---
    var move_spd = carregando ? spd_caixa : spd_max;

    /// --- Input (teclado + WASD) ---
    var key_x = keyboard_check(vk_right) - keyboard_check(vk_left)
              + keyboard_check(ord("D")) - keyboard_check(ord("A"));
    var key_y = keyboard_check(vk_down) - keyboard_check(vk_up)
              + keyboard_check(ord("S")) - keyboard_check(ord("W"));

    var hspd = key_x;
    var vspd = key_y;

    /// --- Joystick ---
    var _deviceControl = 0;
    if (gamepad_is_connected(_deviceControl)) {
        hspd += gamepad_axis_value(_deviceControl, gp_axislh);
        vspd += gamepad_axis_value(_deviceControl, gp_axislv);
    }

    /// --- Normaliza velocidade diagonal ---
    var len = sqrt(hspd*hspd + vspd*vspd);
    if (len > 0) {
        hspd /= len;
        vspd /= len;
    }

    /// --- Define direção olhando ---
    if (abs(key_x) > abs(key_y)) {
        dir = (key_x > 0) ? 0 : 180;
    } else if (abs(key_y) > 0) {
        dir = (key_y > 0) ? 270 : 90;
    }

    /// --- Colisão com paredes ---
    var can_move_x = !place_meeting(x + hspd*move_spd, y, obj_Block);
    var can_move_y = !place_meeting(x, y + vspd*move_spd, obj_Block);

    /// --- Colisão com caixas ---
    var box_x = instance_place(x + hspd*move_spd, y, obj_Box);
    var box_y = instance_place(x, y + vspd*move_spd, obj_Box);

    if (!carregando) {
        if (box_x != noone && box_x.state == BOX_STATE.GROUND) can_move_x = false;
        if (box_y != noone && box_y.state == BOX_STATE.GROUND) can_move_y = false;
    } else {
        if (box_x != noone && box_x != carregando_caixa && box_x.state == BOX_STATE.GROUND) can_move_x = false;
        if (box_y != noone && box_y != carregando_caixa && box_y.state == BOX_STATE.GROUND) can_move_y = false;
    }

    /// --- Aplicar movimento ---
    if (can_move_x) x += hspd * move_spd; else hspd = 0;
    if (can_move_y) y += vspd * move_spd; else vspd = 0;

    /// --- Detectar caixa próxima ---
    var box_to_pick = noone;
    var nearest_dist = 42;
    with (obj_Box) {
        if (state == BOX_STATE.GROUND) {
            var d = point_distance(other.x, other.y, x, y);
            if (d <= nearest_dist) {
                nearest_dist = d;
                box_to_pick = id;
            }
        }
    }

    /// --- Pegar / Soltar caixa ---
    pressed_pick = keyboard_check_pressed(vk_space)
                    || (gamepad_is_connected(_deviceControl) && gamepad_button_check_pressed(_deviceControl, gp_face1));

    if (pressed_pick) {
        // PEGAR
        if (!carregando && box_to_pick != noone) {
            carregando = true;
            carregando_caixa = box_to_pick;
            box_to_pick.state = BOX_STATE.CARRIED;
            box_to_pick.carrego = id;
        }
        // SOLTAR
        else if (carregando) {
            var drop_dist = 48;
            var drop_x = x + lengthdir_x(drop_dist, dir);
            var drop_y = y + lengthdir_y(drop_dist, dir);

            var can_drop = true;

            var original_x = carregando_caixa.x;
            var original_y = carregando_caixa.y;

            carregando_caixa.x = drop_x;
            carregando_caixa.y = drop_y;
            carregando_caixa.state = BOX_STATE.GROUND;

            if (place_meeting(drop_x, drop_y, obj_Block)) can_drop = false;

            var other_box = instance_place(drop_x, drop_y, obj_Box);
            if (other_box != noone && other_box != carregando_caixa) can_drop = false;

            if (!can_drop) {
                carregando_caixa.x = original_x;
                carregando_caixa.y = original_y;
                carregando_caixa.state = BOX_STATE.CARRIED;
            } else {
                carregando_caixa.carrego = noone;
                carregando_caixa = noone;
                carregando = false;
            }
        }
    }

    /// --- Portas ---
    var porta = instance_place(x, y, obj_door);
    if (porta != noone && !obj_Transicao.fading_out && !obj_Transicao.fading_in) {
        obj_Transicao.target_room = porta.room_destino;
        obj_Transicao.spawn_x = porta.spawn_x;
        obj_Transicao.spawn_y = porta.spawn_y;
        obj_Transicao.has_spawn = true;
        obj_Transicao.fading_out = true;
    }

    /// --- Animação do Player ---
    var moving = (hspd != 0 || vspd != 0);
    image_xscale = 1.75;
    image_yscale = 1.75;

    if (moving) {
        if (abs(hspd) > abs(vspd)) {
            sprite_index = (hspd > 0) ? sprt_PlayerRunRight : sprt_PlayerRunLeft;
        } else {
            sprite_index = (vspd > 0) ? sprt_PlayerRunDown : sprt_PlayerRunTop;
        }
    } else {
        if (dir == 0) sprite_index = sprt_PlayerIdleRight;
        else if (dir == 180) sprite_index = sprt_PlayerIdleLeft;
        else if (dir == 90) sprite_index = sprt_PlayerIdleUp;
        else if (dir == 270) sprite_index = sprt_PlayerIdle;
    }

    if (carregando) image_speed = 0.2;
    else if (moving) image_speed = 0.4;
    else image_speed = 0.3;
}
