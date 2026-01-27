var all_pressed = true;

with (obj_Button) {
    if (!pressed) {
        all_pressed = false;
    }
}

if (instance_number(obj_Button) > 0 && all_pressed) {
	open = true;
	instance_destroy();
	
} else {
    solid = true;
}
