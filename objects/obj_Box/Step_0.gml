/// Step Event

// Segue o player se estiver carregada
if (carregar && carrego != noone) {
    x = carrego.x;
    y = carrego.y - 16; // ajusta acima do player
}

// Caixa não é solid, colisão é tratada manualmente no player
solid = false;
