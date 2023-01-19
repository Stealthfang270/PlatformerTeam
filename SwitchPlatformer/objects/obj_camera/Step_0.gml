/// @description 

if(instance_exists(objectToFollow) && !locked) {
	if(smoothMovement) {
		x += ((objectToFollow.x  + xOffset - x) / 25);
		y += ((objectToFollow.y + yOffset - y) / 25);
	} else {
		x = objectToFollow.x + xOffset;
		y = objectToFollow.y + yOffset;
	}
}



