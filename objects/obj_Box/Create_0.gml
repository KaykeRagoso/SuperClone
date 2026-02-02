enum BOX_STATE {
    GROUND,
    CARRIED,
    LOCKED
}

state   = BOX_STATE.GROUND;
carrego = noone;

// Escalas
escala_ground  = 1/1.15; // ≈ 0.87
escala_carried = 1/1.15;

// Começa menor (solta)
image_xscale = escala_ground;
image_yscale = escala_ground;
