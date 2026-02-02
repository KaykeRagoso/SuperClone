switch (state) {
    case BOX_STATE.CARRIED:
        if (carrego != noone) {
            // Segue o player
            x = carrego.x;
            y = carrego.y - sprite_height * 0.70;

            // Escala maior
            image_xscale = escala_carried;
            image_yscale = escala_carried;
        } else {
            state = BOX_STATE.GROUND;
        }
    break;

    case BOX_STATE.GROUND:
        image_xscale = escala_ground;
        image_yscale = escala_ground;
    break;

    case BOX_STATE.LOCKED:
        image_xscale = escala_ground;
        image_yscale = escala_ground;
    break;
}

// --- Profundidade ---
// Caixa carregada sempre acima do player
if (state == BOX_STATE.CARRIED && carrego != noone) {
    depth = carrego.depth - 1;
} else {
    // Caixa no chão ordenada pela posição Y
    depth = -y;
}
