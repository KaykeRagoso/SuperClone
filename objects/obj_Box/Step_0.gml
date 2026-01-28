// Segue o player se estiver carregada
if (carregar && carrego != noone) {
    x = carrego.x;
    y = carrego.y - 16; // ajusta acima do player
	
	 // Se NÃO estiver colidindo, salva a posição
    if (!place_meeting(x, y, obj_Block)) {
        last_x = x;
        last_y = y;
    }
}

// Caixa não é solid, colisão é tratada manualmente no player
solid = false;
