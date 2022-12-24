/// @description Setup variables

//Run parent object code
event_inherited();

//Set basic stats
xSpeed = 0;
ySpeed = 0;
grav = 0.15;

//Collision variables
overlap = ds_list_create();
overlapSize = 0;
inst = noone;
