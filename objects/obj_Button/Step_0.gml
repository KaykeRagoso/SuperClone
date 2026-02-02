if (place_meeting(x,y,obj_Player) || place_meeting(x,y,obj_Box) || place_meeting(x,y,obj_BlocoDeslizante)){
	pressed = true;	
}

if (pressed){
	image_index = 1;	
}else{
	image_index = 0;	
}