// How to use this function:
//Enter the object that is using the function
//Enter the X and Y coordinates you wish to check for an object
//Enter true or false for setNoone, true means that if the object has collision turned off or is not there, the function will set inst to noone
//Make sure the object that is using this function has the following variables(case sensitive): overlapSize, overlap(a DS list), and inst

function get_wall_collision(obj, placeX, placeY, setNoone){
	with(obj) {
		overlapSize = instance_place_list(placeX,placeY,obj_wall,overlap,true);
		if(!ds_list_empty(overlap)) {
			//Grab the item in the list that is furthest away from the player
			inst = ds_list_find_value(overlap, overlapSize - 1);
			if(setNoone) {
				if(!inst.hasCollision) {
					inst = noone;
				}
			}
		} else {
			//If there is nothing in the list, inst = noone
			if(setNoone) {
				inst = noone;
			}
		}
	}
}