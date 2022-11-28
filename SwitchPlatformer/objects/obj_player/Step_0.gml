/// @description movement, collision, and more

/*Platformer Members, PLEASE READ:
A lot of this code is ripped from my previous project, as such, a lot of it is redundant
Or needs to be changed. I should have already updated most of it by the time you're reading this,
however some of the code may still need to be updated. For instance, right now the code checks
for obj_wall when looking for collisions. In the future, this will need to be updated to account
for pulleys, switch tiles, moveable boxes, and potentially more
Ultimately copying this code should save us more time than it loses but some work will have to be
done to make sure it's cleaner and better.*/



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

//Set Xspeed to keyRight - keyLeft in order to handle all X movements in 1 variable
//With this calculation, pressing left should have a value of -4 and pressing right should be 4
var _move = keyRight - keyLeft;

xSpeed = _move * walkSpeed;


//If on the ground
if (place_meeting(x,y+1,obj_wall)) {
	var _inst = instance_place(x,y+1,obj_wall);
	//Set speed to 0 to prevent gravity glitch
	if(_inst.hasCollision) {
		ySpeed = 0;
		canJump = 10;
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

_inst = instance_place(x,y+1,obj_wall);
if(_inst != noone && !_inst.hasCollision) {
	_inst = noone;
}

if(_inst == noone) {
	ySpeed += grav;
}

//Horizontal Collision
//If there is a wall less distance away than the xspeed, instead move the player the distance required
_inst = instance_place(x+xSpeed,y,obj_wall);
if(_inst != noone && !_inst.hasCollision) {
	_inst = noone;
}
if(_inst != noone) {
	while (!place_meeting(x+sign(xSpeed),y,_inst)) {
		x += sign(xSpeed);
	}
} else {
	x += xSpeed;
}

//Vertical Collision
//If there is a wall below the player lower than their yspeed, instead move them the distance required,
//Otherwise move equal to their yspeed
_inst = instance_place(x,y+ySpeed,obj_wall);
if(_inst != noone && !_inst.hasCollision) {
	_inst = noone;
}
if(_inst != noone) {
	while (!place_meeting(x,y+sign(ySpeed),_inst)) {
		y += sign(ySpeed);
	}
	if(place_meeting(x,y-1,_inst)) {
		ySpeed = +1;
	}
} else {
	y += ySpeed;
}

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
}




