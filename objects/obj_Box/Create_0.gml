/// Create Event

carregar = false;     // se a caixa está sendo carregada
carrego  = noone;     // referência do player que está carregando

// Tamanho da zona de interação (hitbox maior que o sprite)
interaction_width  = sprite_width  + 16; // 8 pixels extra em cada lado
interaction_height = sprite_height + 16;

last_x = x;
last_y = y;