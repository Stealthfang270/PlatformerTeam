/// @description Switch States

characterState *= -1;

//Change sprite using ternary operator
sprite_index = characterState == 1 ? spr_comedy : spr_tragedy;
