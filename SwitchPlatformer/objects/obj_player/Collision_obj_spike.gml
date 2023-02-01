/// @description Spike InstaDeath
// You can write your code in this editor

if(!dead) {
	randomize();

	for(var i = 0; i < random_range(minAmt, maxAmt); i++) {
		with(instance_create_layer(x,y,"Player",obj_death_particle)) {
			var size = random_range(other.minSize, other.maxSize);
			image_xscale = size;
			image_yscale = size;
			
			if(other.characterState == 1) {
				image_index = 0;
			} else {
				image_index = 1;
			}
			
			direction = random_range(0, 360);
		
			moveSpeed *= random_range(other.minSpeed, other.maxSpeed);
			moveSpeedMax = moveSpeed;
			decaySeconds = other.decaySeconds;
		}
	}

	with(obj_control) {
		alarm[1] = other.decaySeconds;
	}

	visible = false;
	hasControl = false;
	dead = true;
}
