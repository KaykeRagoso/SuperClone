// Cria a neve em uma posição aleatória no topo da room
var _quantidadeNeve = 2.25;
for(var i = 0; i < _quantidadeNeve; i++){
	instance_create_layer(random(room_width), 0, "Particles", obj_Neve);
}
// Reinicia o alarme para continuar gerando a cada 0.5 segundos
alarm[0] = room_speed * segGerar;
