// Cria a neve em uma posição aleatória no topo da room
instance_create_layer(random(room_width), 0, "Particles", obj_Neve);

// Mensagem de debug
show_debug_message("Criada a neve");

// Reinicia o alarme para continuar gerando a cada 0.5 segundos
alarm[0] = room_speed * segGerar;
