/// @description Initialize
event_inherited();

frameCounterMax = 5;

missileGive = 1;

function OnPlayerPickup()
{
	if (instance_exists(obj_Player))
	{
		items_add_amount(obj_Player.items_state, Item.SMissile, missileGive)
	}
	audio_stop_sound(snd_Pickup_MissileDrop);
	audio_play_sound(snd_Pickup_MissileDrop,0,false);
}