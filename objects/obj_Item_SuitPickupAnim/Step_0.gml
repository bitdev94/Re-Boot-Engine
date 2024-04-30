/// @description Logic

if(global.gamePaused)
{
	exit;
}

var player = obj_Player;
if(instance_exists(player))
{
	player.state = State.Elevator;
	if(player.position.X < x)
	{
		player.position.X = min(player.position.X+1,x);
	}
	else
	{
		player.position.X = max(player.position.X-1,x);
	}
	if(player.position.Y < y)
	{
		player.position.Y = min(player.position.Y+1,y);
	}
	else
	{
		player.position.Y = max(player.position.Y-1,y);
	}
	player.x = scr_round(player.position.X);
	player.y = scr_round(player.position.Y);
	if(animCounter == animCounterMax)
	{
		player.capabilities.suits[animType].obtained = true;
		player.suit[animType] = true;
	}
}
if(animCounter == 1)
{
	audio_play_sound(snd_SuitFlash,0,false);
}
animCounter++;
if(animCounter > animCounterMax*2)
{
	instance_destroy();
}