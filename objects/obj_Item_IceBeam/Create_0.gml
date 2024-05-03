/// @description Initialize
event_inherited();

itemName = "iceBeam";
itemID = 0;

itemHeader = "ICE BEAM";
itemDesc = "Your beam can now freeze most enemies.";

CollectItem = function()
{
	if (instance_exists(obj_Player))
	{
		beam_enable(obj_Player.beam_state, Beam.Ice)
		beam_activate(obj_Player.beam_state, Beam.Ice)
	}
}