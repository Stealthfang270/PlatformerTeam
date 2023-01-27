/// @description Variables and Setup

//Player stats
xSpeed = 0;
ySpeed = 0;
grav = 0.20;
walkSpeed = 4;
walkSpeedBase = 4;
walkSpeedSlower = 1.5;
hasControl = true;
canJump = 0;
maxHP = 3;
hp = maxHP;
jumpHeight = -6;
jumpRelease = -3;
xScale = image_xscale;
characterState = 1;

//Invincibility variables
baseInvFrames = 40;
invFramesReset = baseInvFrames;
invFrames = baseInvFrames;
isInvincible = false;
blinkSwitch = 2;

//Keys (the grouping elements for objects)
canSwitch = true;

//Other stuff
overlap = ds_list_create();
overlapSize = 0;
inst = noone;