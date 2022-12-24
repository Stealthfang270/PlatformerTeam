/// @description movement, collision, and more

/*Platformer Members, PLEASE READ:
A lot of this code is ripped from my previous project, as such, a lot of it is redundant
Or needs to be changed. I should have already updated most of it by the time you're reading this,
however some of the code may still need to be updated. For instance, right now the code checks
for obj_wall when looking for collisions. In the future, this will need to be updated to account
for pulleys, switch tiles, moveable boxes, and potentially more
Ultimately copying this code should save us more time than it loses but some work will have to be
done to make sure it's cleaner and better.*/

inst = noone;

canJump -= 1;
//Player input
//If the player has control
if(hasControl) {
	//Check for keys that the player is pressing
	keyLeft = keyboard_check(vk_left) || keyboard_check(ord("A"));
	keyRight = keyboard_check(vk_right) || keyboard_check(ord("D"));
	keyJump = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_space);
	keyJumpHeld = keyboard_check(vk_up) || keyboard_check(ord("W")) || keyboard_check(vk_space);
} else {
	//If no keys are pressed, reset values to 0
	keyLeft = 0;
	keyRight = 0;
	keyJump = 0;
	keyJumpHeld = 0;
}

//Check if player is next to crate

if(instance_exists(obj_crate)) {
	var _crate = collision_rectangle(bbox_left-6,y-1,bbox_right+6,y,obj_crate,false,true);
	//Check if crate has collision
	if(_crate != noone) {
		if(_crate.hasCollision = false){
			_crate = noone;
		}
	}
	//If crate is next to player and does have collision, slow player speed.
	if(_crate != noone) {
		walkSpeed = walkSpeedSlower;
		
	} else {
		walkSpeed = walkSpeedBase;
	}
}

//Set Xspeed to keyRight - keyLeft in order to handle all X movements in 1 variable
//With this calculation, pressing left should have a value of -4 and pressing right should be 4
var _move = keyRight - keyLeft;


xSpeed = _move * walkSpeed;





//If on the ground
if (place_meeting(x,y+1,obj_wall)) {
	get_wall_collision(self,x,y+1,false);
	
	//Set speed to 0 to prevent gravity glitch
	if(inst.hasCollision) {
		ySpeed = 0;
		canJump = 10;
	}
}

ds_list_clear(overlap);

//if inside of wall(with or without collision)
if(place_meeting(x,y,obj_wall)) {
	canSwitch = false;
} else {
	canSwitch = true;
}

//if crate is inside of wall
if(instance_exists(obj_crate)) {
	with(obj_crate) {
		if(place_meeting(x,y,obj_wall)) {
		obj_player.canSwitch = false;
		} else {
			obj_player.canSwitch = true;
		}
	}
}

//If able to jump
if(keyJump && canJump > 0) {
	ySpeed = jumpHeight;
	canJump = 0;
}


if (ySpeed < 0 && !keyJumpHeld) {
	ySpeed = max(ySpeed, jumpRelease);
}


//Implement gravity

get_wall_collision(self, x, y+1, true);

if(inst == noone) {
	ySpeed += grav;
}

ds_list_clear(overlap);


//********************
//Horizontal Collision
//*********************


get_wall_collision(self,x + xSpeed,y,true);

//If there is a wall less distance away than the xspeed, instead move the player the distance required
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

//******************
//Vertical Collision
//******************


get_wall_collision(self,x,y+ySpeed,true);

//If there is a wall below the player lower than their yspeed, instead move them the distance required,
//Otherwise move equal to their yspeed
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

//Handle Animations

//All the commented out code in this section is due to the fact that this was a chunk
//of code that was mostly intended to handle animations, of which have not yet
//been implemented


//Handle invincibility
if(isInvincible && invFrames > 0) {
	//Blink
	if(blinkSwitch > 0) {
		blinkSwitch--;
	} else {
		if(visible) {
			blinkSwitch = 2;
			visible = false;
		} else {
			blinkSwitch = 2;
			visible = true;
		}
	}
	invFrames--;
} else if (isInvincible && invFrames <= 0) {
	//Reset visibility and invincibility
	visible = true;
	isInvincible = false;
	invFrames = invFramesReset;
}


//Restarts room when HP = 0

if(hp == 0){
	room_restart();
}

