// --- Definindo as variáveis do Player ---
spd_max = 1.75;
spd_caixa = 1;
hspd = 0;
vspd = 0;

life = 3;
max_life = life;

life_offset_x = 32;
life_offset_y = 64;

grid = 32;

carregando_spd = 2;
carregando = false;
carregando_caixa = noone;

// Direção inicial
dir = 0;          // variável antiga (não usar mais para hook)
look_dir = 270;   // nova variável para direção olhando (inicial: para baixo)

// Controle de pegar/soltar
pressed_pick = false;
