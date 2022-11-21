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
	//Set speed to 0 to prevent gravity glitch
	ySpeed = 0;
}

//If able to jump
if(keyJump && canJump > 0) {
	ySpeed = jumpHeight;
	canJump = 0;
}


if (ySpeed < 0 && !keyJumpHeld) {
	ySpeed = max(ySpeed, jumpRelease);
}

if(!place_meeting(x,y+1,obj_wall)) {
	ySpeed += grav;
}

//Horizontal Collision
//If there is a wall less distance away than the xspeed, instead move the player the distance required
if(place_meeting(x+xSpeed,y,obj_wall)) {
	while (!place_meeting(x+sign(xSpeed),y,obj_wall)) {
		x += sign(xSpeed);
	}
} else {
	x += xSpeed;
}

//Vertical Collision
//If there is a wall below the player lower than their yspeed, instead move them the distance required,
//Otherwise move equal to their yspeed
if(place_meeting(x,y+ySpeed,obj_wall)) {
	while (!place_meeting(x,y+sign(ySpeed),obj_wall)) {
		y += sign(ySpeed);
	}
	if(place_meeting(x,y-1,obj_wall)) {
		ySpeed = +1;
	}
} else {
	y += ySpeed;
}

//Handle Animations

//All the commented out code in this section is due to the fact that this was a chunk
//of code that was mostly intended to handle animations, of which have not yet
//been implemented
if (!place_meeting (x,y+1,obj_wall)) {
	//sprite_index = spr_player_jump;
	//if(sign(ySpeed) < 0) {
	//	image_index = 0;
	//} else {
	//	image_index = 1;
	//}
} else {
	canJump = 10;
	//if(sprite_index == spr_player_jump) {
	//	audio_play_sound(snd_land,1,0);
	//	repeat(5) {
	//		with(instance_create_layer(x,bbox_bottom,"Bullet",obj_dust)) {
	//			ySpeed = 0;
	//		}
	//	}
	//}
	//if(xSpeed == 0) {
	//	sprite_index = spr_player;
	//} else {
	//	sprite_index = spr_player_run;
	//}
}

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




