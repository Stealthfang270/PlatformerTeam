/// @description 



x += lengthdir_x(moveSpeed,direction);
y += lengthdir_y(moveSpeed,direction);

moveSpeed = max(0, moveSpeed - (moveSpeedMax/decaySeconds));
