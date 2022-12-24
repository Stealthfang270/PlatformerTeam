/// @description 



//Check if the player has control and if so set the key to switch to X or E
if(instance_exists(obj_player)) {
	if(obj_player.hasControl && obj_player.canSwitch) {
		keySwitch = keyboard_check_pressed(ord("X")) || keyboard_check_pressed(ord("E"));
	}
}



if(keySwitch) {
	with(all) {
		if(variable_instance_exists(self, "canSwitch")) {
			if(canSwitch == true) {
				show_debug_message("Object attempted switch: " + object_get_name(object_index));
				alarm[0] = 1;
			}
		}
	}
	//Change background. This is not the method we will use in the final game
	//But it is a temporary solution
	if(layer_background_get_index(layer_background_get_id("Background")) == 0) {
		layer_background_index(layer_background_get_id("Background"), 1);
	} else {
		layer_background_index(layer_background_get_id("Background"), 0);
	}
}