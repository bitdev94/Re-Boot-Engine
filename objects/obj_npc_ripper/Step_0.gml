/// @description 
event_inherited();
if(PauseAI())
{
	exit;
}

velX = mSpeed*dir;

fVelX = velX;
fVelY = velY;
Collision_Normal(fVelX,fVelY,16,16,false,false);