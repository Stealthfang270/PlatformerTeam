/// @description Handle collision and movement


//Check for player inputs(left or right only)
if(instance_exists(obj_player)) {
	if(obj_player.hasControl) {
		keyLeft = keyboard_check(vk_left) || keyboard_check(ord("A"));
		keyRight = keyboard_check(vk_right) || keyboard_check(ord("D"));
	} else {
		keyLeft = 0;
		keyRight = 0;
	}
}

//If on the ground
if (place_meeting(x,y+1,obj_wall)) {
	get_wall_collision(self,x,y+1,false);
	
	//Set speed to 0 to prevent gravity glitch
	if(inst.hasCollision) {
		ySpeed = 0;
	}
}

ds_list_clear(overlap);


//Implement gravity
get_wall_collision(self, x, y+1, true);

if(inst == noone) {
	ySpeed += grav;
}

ds_list_clear(overlap);

//Determine if there is a player next to it
//Check box has collision
if(hasCollision) {
	if(instance_exists(obj_player)) {
		if(place_meeting(x-1,y,obj_player) && keyRight) {
			xSpeed = obj_player.xSpeed;
		} else if(place_meeting(x+1,y,obj_player) && keyLeft) {
			xSpeed = obj_player.xSpeed;
		} else {
			xSpeed = 0;
		}
	}
} else {
	xSpeed = 0;
}

//Horizontal collision

get_wall_collision(self,x + xSpeed,y,true);

//If there is a wall less distance away than the xspeed, instead move the crate the distance required
if(inst != noone && !inst.hasCollision) {
	inst = noone;
}
if(inst != noone) {
	while (!place_meeting(x+sign(xSpeed),y,inst)) {
		x += sign(xSpeed);
	}
} else {
	x += xSpeed;
}

ds_list_clear(overlap);

//Vertical collision

get_wall_collision(self,x,y+ySpeed,true);

//If there is a wall below the crate lower than their yspeed, instead move it the distance required,
//Otherwise move equal to its yspeed
if(inst != noone) {
	while (!place_meeting(x,y+sign(ySpeed),inst)) {
		y += sign(ySpeed);
	}
	if(place_meeting(x,y-1,inst)) {
		ySpeed = +1;
	}
} else {
	y += ySpeed;
}

//empty the list after
ds_list_clear(overlap);